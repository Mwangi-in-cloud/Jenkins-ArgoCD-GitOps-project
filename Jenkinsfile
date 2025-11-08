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
        stage ("now pushing sir") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-creds', passwordVariable: 'DOCKERHUB_PWD', usernameVariable: 'DOCKERHUB_USER')]) {   
                sh 'echo "DOCKERHUB_PWD" | docker login -u "$DOCKERHUB_USER" --password0-stdin'
                sh docker push "$IMAGE:$TAG"
                }
            }
        }
    }
}