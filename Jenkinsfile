pipeline {
    agent any
    
    environment {
        // This binds the Jenkins credential ID 'dockerhub-creds' to variables
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds') 
        IMAGE_NAME = "vigneshvr46/my-first-app:v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building image: ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Use the automatically generated _USR and _PSW variables to log in securely
                    sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    
                    echo "Pushing image to Docker Hub..."
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }
    
    post {
        always {
            // Good practice: log out to prevent leaving credentials on the agent
            sh "docker logout"
        }
    }
}
