pipeline {
    agent any

    environment {
        REGISTRY = 'local-registery' 
        IMAGE_NAME = 'my-java-app-image'   
        GITHUB_REPO = 'https://github.com/aysegulbulur/aysegul-docker-sprinboot-proje.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                sh 'echo Projeyi GitHub dan cek'
                git "${GITHUB_REPO}"
            }
        }

        stage('Compile and Clean') {
            steps {
                sh 'echo Compile and Clean'
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'echo Testing...'
                sh 'mvn test'
            }

            post { 
                always { 
                    sh 'echo Test raporları işleniyor...'
                    junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo Deploying...'
                sh 'mvn package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'echo Build Docker image...'
                sh 'docker build -t ${REGISTRY}/${IMAGE_NAME}:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo Docker Login...'
                withCredentials([string(credentialsId: 'DockerId', variable: 'Dockerpwd')]) {
                    sh 'docker login -u aysegulbulur -p ${Dockerpwd}'
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh 'echo Docker Push...'
                sh 'docker push ${REGISTRY}/${IMAGE_NAME}:latest'
            }
        }

        stage('Run Docker Image') {
            steps {
                sh 'echo Running Docker image...'
                sh 'docker run -d --name ${IMAGE_NAME}-container ${REGISTRY}/${IMAGE_NAME}:latest'
            }
        }

        stage('Archiving') {
            steps {
                sh 'echo Archiving...'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline tamamlandı.'
        }
    }
}

