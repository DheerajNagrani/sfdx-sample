pipeline {
  agent any

  environment {
    SF_USERNAME  = credentials('SF_USERNAME')
    SF_CLIENT_ID = credentials('SF_CLIENT_ID')
  }

  stages {
    stage('Checkout') {
      when { changeRequest(target: 'main') }
      steps {
        checkout scm
      }
    }

    stage('Authenticate Salesforce') {
      when { changeRequest(target: 'main') }
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
      when { changeRequest(target: 'main') }
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
      echo "✅ Validation successful for PR to main"
    }
    failure {
      echo "❌ Validation failed for PR to main"
    }
  }
}
