pipeline{

    agent any

    parameters {
      choice choices: ['chrome', 'firefox'], description: 'Select a browser: chrome, firefox', name: 'BROWSER'
      choice choices: ['smoke.xml', 'regression.xml'], description: 'Select a browser: smoke.xml, regression.xml', name: 'TEST_SUITE'
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
                    if(fileExists('output/test-suite/testng-failed.xml'))
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