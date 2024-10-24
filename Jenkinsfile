pipeline{

    agent any

    stages{

        stage('Start Grid'){
            steps{
                sh "docker-compose -f grid.yaml up -d"
            }
        }

        stage('Run Test'){
            steps{
                sh "docker-compose -f selenium.yaml up --pull=always"
            }
        }

    }

    post {
        always {
            sh "docker-compose -f grid.yaml down"
            sh "docker-compose -f selenium.yaml down"
            archiveArtifacts artifacts: 'output/qaplayground_smoke/emailable-report.html', followSymlinks: false
            archiveArtifacts artifacts: 'output/qaplayground_regression/emailable-report.html', followSymlinks: false
        }
    }

}