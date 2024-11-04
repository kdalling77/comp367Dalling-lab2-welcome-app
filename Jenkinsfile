pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "MAVEN3"
    }

     environment {
        DOCKER_CREDENTIALS_ID = 'my-docker-hub-credentials'  // ID for Docker Hub credentials in Jenkins
        DOCKER_IMAGE_NAME = 'kdalling/welcome-app-image'  // Replace with your Docker Hub username and image name
    }

    stages {
        
        
        stage('check out')
        {
            steps{
             
             checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kdalling77/comp367Dalling-lab2-welcome-app.git']])
        
            }
        }
        
        
        
        stage('Build Maven Project') {
            steps {

                // Run Maven on a Windows agent.
                bat "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub using credentials stored in Jenkins
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                // Build the Docker image for the project
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                // Push the Docker image to Docker Hub
                script {
                    sh "docker push ${DOCKER_IMAGE_NAME}"
                }
            }
        }


    }
}