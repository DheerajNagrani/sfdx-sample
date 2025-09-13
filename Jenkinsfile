pipeline {
  agent any

  environment {
    SF_USERNAME  = credentials('SF_USERNAME')
    SF_CLIENT_ID = credentials('SF_CLIENT_ID')
  }

  options {
    timestamps()
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
        githubNotify context: 'Jenkins SFDX Validation', status: 'PENDING', description: 'Build started'
      }
    }

    stage('Authenticate Salesforce') {
      steps {
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
      githubNotify context: 'Jenkins SFDX Validation', status: 'SUCCESS', description: 'Validation successful'
      echo "✅ Validation successful"
    }
    failure {
      githubNotify context: 'Jenkins SFDX Validation', status: 'FAILURE', description: 'Validation failed'
      echo "❌ Validation failed"
      error("Stopping pipeline due to validation failure")
    }
  }
}
