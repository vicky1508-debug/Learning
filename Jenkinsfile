pipeline {
    agent {
        docker {
            // Spin up a Linux-based container with Docker installed inside
            image 'docker:24.0-cli' 
            // Mount the host's Docker socket so the container can run Docker commands
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        // Define your Docker Image Registry name
        IMAGE_NAME = "my-app-image"
        TAG        = "${BUILD_NUMBER}"
        REGISTRY   = "your-dockerhub-username" // Change this to your registry
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling latest code from GitHub main branch...'
                checkout scm
            }
        }

        stage('Lint & Test') {
            steps {
                echo 'Running quality checks and unit tests...'
                // Example: Shorthand syntax to verify local script syntax
                sh 'find . -name "*.sh" -exec bash -n {} +'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
                sh "docker build -t ${IMAGE_NAME}:${TAG} ."
                sh "docker tag ${IMAGE_NAME}:${TAG} ${REGISTRY}/${IMAGE_NAME}:${TAG}"
            }
        }

        stage('Push to Registry') {
            steps {
                echo 'Logging into Docker Registry and pushing image...'
                // Safely injects Docker credentials configured in your Jenkins dashboard
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline built and deployed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check the console output logs above."
        }
    }
}

