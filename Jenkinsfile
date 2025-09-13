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
        githubNotify context: 'jenkins/sfdx-validation', status: 'PENDING', description: 'Checkout in progress'
      }
    }

    stage('Authenticate Salesforce') {
      steps {
        githubNotify context: 'jenkins/sfdx-validation', status: 'PENDING', description: 'Authenticating Salesforce'
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
        githubNotify context: 'jenkins/sfdx-validation', status: 'PENDING', description: 'Running validation deploy'
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
      githubNotify context: 'jenkins/sfdx-validation', status: 'SUCCESS', description: '✅ Validation successful'
    }
    failure {
      githubNotify context: 'jenkins/sfdx-validation', status: 'FAILURE', description: '❌ Validation failed'
    }
  }
}
