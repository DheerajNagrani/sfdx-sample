pipeline {
  agent any

  environment {
    SF_USERNAME  = credentials('SF_USERNAME')
    SF_CLIENT_ID = credentials('SF_CLIENT_ID')
  }

  stages {
    stage('Checkout') {
      steps {
        script {
          githubNotify context: 'Jenkins Build', status: 'PENDING', description: 'Checking out code'
        }
        checkout scm
      }
    }

    stage('Authenticate Salesforce') {
      steps {
        script {
          githubNotify context: 'Jenkins Build', status: 'PENDING', description: 'Authenticating Salesforce'
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
          githubNotify context: 'Jenkins Build', status: 'PENDING', description: 'Running validation deploy'
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
        githubNotify context: 'Jenkins Build', status: 'SUCCESS', description: 'Validation successful'
      }
      echo "✅ Validation successful"
    }
    failure {
      script {
        githubNotify context: 'Jenkins Build', status: 'FAILURE', description: 'Validation failed'
      }
      echo "❌ Validation failed"
      error("Stopping pipeline due to validation failure")
    }
  }
}
