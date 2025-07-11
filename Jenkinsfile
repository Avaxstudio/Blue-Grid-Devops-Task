pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        IMAGE_NAME = 'bluegrid-app'
        CONTAINER_NAME = 'bluegrid-container'
        EXTERNAL_PORT = '777'
        INTERNAL_PORT = '8080'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven Wrapper') {
            steps {
                dir('complete') {
                    sh 'chmod +x mvnw'
                    sh './mvnw clean package -DskipTests=true'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} \
                      -p ${EXTERNAL_PORT}:${INTERNAL_PORT} ${IMAGE_NAME}
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh 'sleep 5'
                sh 'curl -f http://localhost:${EXTERNAL_PORT}/greeting'
            }
        }
    }

    post {
        always {
            echo '🧹 Final cleanup...'
            cleanWs()
        }
    }
}
