pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and Test') {
            steps {
                sh 'echo "Building and testing the web application..."'
                // Add build and test commands here
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'echo "Building Docker image..."'
                sh 'docker build -t simple-web-app:${BUILD_NUMBER} .'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'echo "Pushing Docker image..."'
                withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_HUB_CREDENTIALS')]) {
                    sh "docker login -u ${DOCKER_HUB_CREDENTIALS_USR} -p ${DOCKER_HUB_CREDENTIALS_PSW}"
                }
                sh "docker push simple-web-app:${BUILD_NUMBER}"
            }
        }
        stage('Deploy to Docker') {
            steps {
                sh 'echo "Deploying the application..."'
                sh "docker run -d -p 8080:80 simple-web-app:${BUILD_NUMBER}"
            }
        }
    }
}
