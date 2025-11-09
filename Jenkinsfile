pipeline {
    agent any
    environment {
        IMAGE = "docker.io/cronosm4m/nileproj"
        TAG = "${env.BUILD_NUMBER}"
    }
    stages{
        stage ("checking out" ) {
            steps {
                git branch: 'main', credentialsId: 'github-creds', url: 'https://github.com/Mwangi-in-cloud/Jenkins-ArgoCD-GitOps-project.git'
            }
        }
        stage ("now building") {
            steps {
                sh 'docker build -t "$IMAGE:$TAG" .'
            }
        }
        stage ("trivy scan") {
            steps {
                sh """
                  #trivy image --severity HIGH,CRITICAL --no-progress --format table -o trivy-scan-report.txt ${IMAGE}:${TAG}
                  #trivy --severity HIGH,CRITICAL --skip-db-update --no-progress image --format table -o trivy-scan-report.txt ${IMAGE}:${TAG}
                """
            }
        }
        stage ("now pushing sir") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'DOCKERHUB_PWD', usernameVariable: 'DOCKERHUB_USER')]) {   
                sh 'echo "$DOCKERHUB_PWD" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                sh 'docker push "$IMAGE:$TAG"'
                sh 'docker push "$IMAGE:latest"'
                }
            }
        }
        stage ("pull it now") {
            steps {
                sh 'docker pull "$IMAGE:$TAG"'
                sh 'docker rm -f final || true'
                sh 'docker run -d --name final -p 5001:5000 "$IMAGE:$TAG"'
            }
        }
        stage ("now to CD part") {
            steps {
                echo "already installed ..... skipping"
            }
        }
        stage ("applying manifests and sync argo") {
            steps {
                script {
                    kubeconfig(credentialsId: 'cluster-creds', serverUrl: 'https://172.31.4.103:6443') {
                         sh '''
                         argocd login 65.0.7.142:30434 --username admin --password $(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure
						 argocd app sync argocdjenkins
                         '''
                    }
                }
            }
        }
    }
}