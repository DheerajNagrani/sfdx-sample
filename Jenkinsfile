pipeline {
  agent any

  environment {
    # Salesforce auth details (stored in Jenkins Credentials)
    SF_USERNAME   = credentials('SF_USERNAME')
    SF_CLIENT_ID  = credentials('SF_CLIENT_ID')
    SF_JWT_KEY    = credentials('SF_JWT_KEY')   // secret file credential
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Authenticate Salesforce') {
      steps {
        withCredentials([file(credentialsId: 'SF_JWT_KEY', variable: 'JWT_KEY_FILE')]) {
          sh '''
            echo "Authenticating to Salesforce..."
            sfdx auth:jwt:grant \
              --clientid $SF_CLIENT_ID \
              --jwtkeyfile $JWT_KEY_FILE \
              --username $SF_USERNAME \
              --instanceurl https://test.salesforce.com
          '''
        }
      }
    }

    stage('Validate Deployment') {
      steps {
        sh '''
          echo "Running validation deploy..."
          sfdx force:source:deploy \
            -p force-app/main/default \
            -u $SF_USERNAME \
            --checkonly \
            --testlevel RunLocalTests \
            --wait 20
        '''
      }
    }
  }

  post {
    success {
      echo "✅ Validation successful"
    }
    failure {
      echo "❌ Validation failed"
      error("Stopping pipeline due to validation failure")
    }
  }
}
