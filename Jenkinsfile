pipeline{
    agent any
    stages {
        stage('Grid up and run tests') {
            steps {
                bat "docker-compose -f grid.yaml up --scale chrome=2 -d"
                bat "set BROWSER=chrome"
                bat "docker-compose -f selenium.yaml up"
            }
        }
        stage('Grid down') {
            steps {
                bat "docker-compose -f grid.yaml down"
                bat "docker-compose -f selenium.yaml down"
            }
        }
    }
}