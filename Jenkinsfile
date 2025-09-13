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
        script {
          setGitHubPullRequestStatus state: 'PENDING',
                                     context: 'Jenkins SFDX Validation',
                                     message: 'Authenticating to Salesforce...'
        }
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
        script {
          setGitHubPullRequestStatus state: 'PENDING',
                                     context: 'Jenkins SFDX Validation',
                                     message: 'Running validation deployment...'
        }
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
      script {
        setGitHubPullRequestStatus state: 'SUCCESS',
                                   context: 'Jenkins SFDX Validation',
                                   message: '✅ Validation successful'
      }
      echo "✅ Validation successful"
    }
    failure {
      script {
        setGitHubPullRequestStatus state: 'FAILURE',
                                   context: 'Jenkins SFDX Validation',
                                   message: '❌ Validation failed'
      }
      echo "❌ Validation failed"
      error("Stopping pipeline due to validation failure")
    }
  }
}
