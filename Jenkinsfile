pipeline {
    agent any
    environment {
        IMAGE = "docker.io/cronosm4m/pipeline"
        TAG = "${env.BUILD_NUMBER}"
    }
    stages{
        stage (checking out ) {
            steps {
                git branch: 'main', credentialsId: 'github-creds', url: 'https://github.com/Mwangi-in-cloud/Jenkins-ArgoCD-GitOps-project.git'
            }
        }
    }
}