pipeline {
    agent any

    environment {
        IMAGE_NAME = 'cicd-demo'
        CONTAINER_NAME = 'cicd-demo-app'
        APP_PORT = '8080'
    }

    options {
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build And Test') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw clean test package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'chmod +x scripts/deploy.sh'
                sh './scripts/deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline tamamlandi. Uygulama Docker uzerinde guncel haliyle calisiyor.'
        }
        failure {
            echo 'Pipeline basarisiz oldu. Jenkins konsol kayitlarini kontrol edin.'
        }
    }
}
