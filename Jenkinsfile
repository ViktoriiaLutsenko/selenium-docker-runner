pipeline{

    agent any

    parameters {
      choice choices: ['chrome', 'firefox'], description: 'Select a browser: chrome, firefox', name: 'BROWSER'
    }


    stages{

        stage('Start Grid'){
            steps{
                bat "docker-compose -f grid.yaml up --scale ${params.BROWSER}=2 -d"
            }
        }

        stage('Run Test'){
            steps{
                bat "docker-compose -f selenium.yaml  up --pull=always"
                script {
                    if(fileExists('output/qaplayground_smoke/testng-failed.html') || fileExists('output/qaplayground_regression/testng-failed.html'))
                    error('failed test found')
                }
            }
        }

    }

    post {
        always {
            bat "docker-compose -f grid.yaml down"
            bat "docker-compose -f selenium.yaml down"
            archiveArtifacts artifacts: 'output/qaplayground_smoke/emailable-report.html', followSymlinks: false
            archiveArtifacts artifacts: 'output/qaplayground_regression/emailable-report.html', followSymlinks: false
        }
    }

}