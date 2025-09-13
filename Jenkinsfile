pipeline {
  agent any

  environment {
    SF_USERNAME  = credentials('SF_USERNAME')
    SF_CLIENT_ID = credentials('SF_CLIENT_ID')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Authenticate Salesforce') {
      steps {
        publishChecks name: 'Jenkins SFDX Validation',
                      status: 'IN_PROGRESS',
                      summary: 'Authenticating to Salesforce...'
        withCredentials([file(credentialsId: 'SF_JWT_KEY', variable: 'JWT_KEY_FILE')]) {
          sh '''
            echo "Authenticating to Salesforce..."
            sf org login jwt \
              --client-id $SF_CLIENT_ID \
              --jwt-key-file $JWT_KEY_FILE \
              --username $SF_USERNAME \
              --instance-url https://test.salesforce.com \
              --alias myOrg
          '''
        }
      }
    }

    stage('Validate Deployment') {
      steps {
        githubNotify context: 'jenkins/validation', status: 'PENDING'
        sh '''
          echo "Running validation deploy..."
          sf project deploy start \
            --source-dir force-app/main/default \
            --target-org $SF_USERNAME \
            --wait 20
        '''
      }
    }
  }

  post {
    success {
      githubNotify context: 'jenkins/validation', status: 'SUCCESS'
    }
    failure {
      githubNotify context: 'jenkins/validation', status: 'FAILURE'
    }
  }
}
