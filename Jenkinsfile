pipeline {
    agent { 
        label 'node 1' 
    }
    
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds') 
        IMAGE_NAME = "vigneshvr46/my-first-app:v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Build Image') {
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing to Docker Hub...'
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push ${IMAGE_NAME}"
            }
        }
        
        stage('Deploy to Server') {
            steps {
                echo 'Deploying to Docker Instance...'
                sh "docker rm -f my-running-app || true"
                sh "docker run -d -p 80:80 --name my-running-app ${IMAGE_NAME}"
            }
        }
    }
}
