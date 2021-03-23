pipeline {
    agent any

    stages {
        stage('Sonar') {
            steps {
                withSonarQubeEnv('sonarcloud') {
                    sh "./mvnw sonar:sonar -Dsonar.branch.name=${env.BRANCH_NAME}"
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
