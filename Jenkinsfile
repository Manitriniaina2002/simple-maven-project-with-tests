pipeline {
    agent any
    tools {
        maven 'Maven-3.9'
        jdk 'JDK-17'
    }
    
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('DOCKER_HUB_CREDENTIALS')
        DOCKER_IMAGE_NAME = 'your-dockerhub-username/your-app-name'
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Compile and Test') {
            steps {
                bat 'mvn -B -ntp -Dmaven.test.failure.ignore verify'
            }
        }
        
        stage('Publish Test Results') {
            steps {
                junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    bat "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} -t ${DOCKER_IMAGE_NAME}:latest ."
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                script {
                    // Login to DockerHub and push the image
                    bat """
                        echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin
                        docker push ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}
                        docker push ${DOCKER_IMAGE_NAME}:latest
                        docker logout
                    """
                }
            }
        }
    }
    
    post {
        always {
            // Clean up local Docker images to save space
            script {
                bat """
                    docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} || true
                    docker rmi ${DOCKER_IMAGE_NAME}:latest || true
                """
            }
        }
        success {
            echo 'Pipeline succeeded! Docker image pushed to DockerHub.'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
