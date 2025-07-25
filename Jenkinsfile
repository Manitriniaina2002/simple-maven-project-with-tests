pipeline {
    agent any
    tools {
        maven 'Maven-3.9'
        jdk 'JDK-17'
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
    }
}
