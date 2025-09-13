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
        step([$class: 'GitHubCommitStatusSetter',
              contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: 'Jenkins SFDX Validation'],
              statusResultSource: [$class: 'ConditionalStatusResultSource',
                results: [[state: 'PENDING', message: 'Authenticating to Salesforce...']]
              ]
        ])
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
        step([$class: 'GitHubCommitStatusSetter',
              contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: 'Jenkins SFDX Validation'],
              statusResultSource: [$class: 'ConditionalStatusResultSource',
                results: [[state: 'PENDING', message: 'Running validation deployment...']]
              ]
        ])
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
      step([$class: 'GitHubCommitStatusSetter',
            contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: 'Jenkins SFDX Validation'],
            statusResultSource: [$class: 'ConditionalStatusResultSource',
              results: [[state: 'SUCCESS', message: '✅ Validation successful']]
            ]
      ])
    }
    failure {
      step([$class: 'GitHubCommitStatusSetter',
            contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: 'Jenkins SFDX Validation'],
            statusResultSource: [$class: 'ConditionalStatusResultSource',
              results: [[state: 'FAILURE', message: '❌ Validation failed']]
            ]
      ])
    }
  }
}
