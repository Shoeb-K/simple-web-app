pipeline {
    agent any

    stages {
stage('Checkout') {
    steps {
        // Check out the repository using SSH key
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'git@github.com:Shoeb-K/simple-web-app.git']], extensions: [[$class: 'CleanBeforeCheckout']], credentialsId: 'GitHubSSH'])
    }
}


        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    def imageName = "simple-web-app:${env.BUILD_NUMBER}"
                    docker.build(imageName, '.')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        def imageName = "simple-web-app:${env.BUILD_NUMBER}"
                        docker.image(imageName).push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker container
                    def containerName = "simple-web-app-container-${env.BUILD_NUMBER}"
                    def imageName = "simple-web-app:${env.BUILD_NUMBER}"
                    sh "docker run -d -p 8080:80 --name ${containerName} ${imageName}"
                }
            }
        }
    }

    post {
        always {
            // Clean up resources
            sh "docker rm -f ${containerName}"
        }
    }
}
