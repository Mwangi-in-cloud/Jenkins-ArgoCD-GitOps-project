pipeline {
    agent any
    environment {
        IMAGE = "docker.io/cronosm4m/pipeline"
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
                  ##trivy image --severity HIGH,CRITICAL --no-progress --format table -o trivy-scan-report.txt ${IMAGE}:${TAG}
                  trivy --severity HIGH,CRITICAL --skip-update --no-progress image --format table -o trivy-scan-report.txt ${IMAGE}:${TAG}
                """
            }
        }
        stage ("now pushing sir") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'DOCKERHUB_PWD', usernameVariable: 'DOCKERHUB_USER')]) {   
                sh 'echo "$DOCKERHUB_PWD" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                sh 'docker push "$IMAGE:$TAG"'
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
    }
}