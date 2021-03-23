pipeline {
    agent any

    stages {
        stage('Sonar') {
            agent {
                     docker { 
                         image 'adoptopenjdk/maven-openjdk11'
                         args '-v $HOME/.m2:/root/.m2'
                     }
            }
            steps {
                withSonarQubeEnv('sonarcloud') {
                    sh "mvn clean verify sonar:sonar -Dsonar.branch.name=${env.BRANCH_NAME} -D sonar.projectKey=benjvi_minimal-spring-web-demo" 
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
