pipeline {
  agent any

  environment {
    SF_USERNAME  = credentials('SF_USERNAME')
    SF_CLIENT_ID = credentials('SF_CLIENT_ID')
  }

  triggers {
    // only run on main branch
    pollSCM('')
  }

  stages {
    stage('Checkout') {
      when {
        branch 'main'
      }
      steps {
        checkout scm
      }
    }

    stage('Authenticate Salesforce') {
      when {
        branch 'main'
      }
      steps {
        echo "Authenticating to Salesforce..."

        withCredentials([file(credentialsId: 'SF_JWT_KEY', variable: 'JWT_KEY_FILE')]) {
          sh '''
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
