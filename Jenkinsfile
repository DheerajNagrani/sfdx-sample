pipeline {
  agent any

  triggers {
    // Trigger on GitHub push and PR events
    githubPush()
  }

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

    stage('Validate or Deploy') {
      steps {
        script {
          if (env.CHANGE_ID && (env.CHANGE_TARGET == 'main' || env.CHANGE_TARGET == 'develop')) {
            echo "Running validation for PR #${env.CHANGE_ID} targeting ${env.CHANGE_TARGET}"
            sh '''
              sf project deploy validate \
                --source-dir force-app/main/default \
                --target-org $SF_USERNAME \
                --wait 20
            '''
          } else if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'develop') {
            echo "Running full deploy for branch ${env.BRANCH_NAME}"
            sh '''
              sf project deploy start \
                --source-dir force-app/main/default \
                --target-org $SF_USERNAME \
                --wait 20
            '''
          } else {
            echo "Skipping deploy: not a PR to main/develop or direct run on other branches."
          }
        }
      }
    }

    stage('Run PMD') {
  steps {
    sh '''
      echo "Downloading and running PMD..."
      curl -L -o pmd-bin.zip https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.55.0/pmd-bin-6.55.0.zip
      unzip -o pmd-bin.zip

      echo "Running PMD analysis..."
      ./pmd-bin-6.55.0/bin/run.sh pmd \
        -d force-app/main/default/classes \
        -R category/apex/design.xml \
        -R category/apex/bestpractices.xml \
        -R category/apex/errorprone.xml \
        -f html \
        -r pmd-report.html || true

      echo "Checking if PMD report exists..."
      ls -l pmd-report.html || echo "❌ PMD report not found!"
    '''
    // Save PMD report as an artifact
    archiveArtifacts artifacts: 'pmd-report.html', fingerprint: true
    // Publish report in Jenkins UI
    publishHTML(target: [
      allowMissing: true,
      keepAll: true,
      reportDir: '.',
      reportFiles: 'pmd-report.html',
      reportName: 'PMD Analysis Report'
    ])
  }
}

  }

  post {
    success {
      script {
        if (env.CHANGE_ID) {
          echo "✅ Validation successful for PR #${env.CHANGE_ID}"
        } else {
          echo "✅ Deployment successful for branch ${env.BRANCH_NAME}"
        }
      }
    }
    failure {
      script {
        def msg = env.CHANGE_ID ?
          "❌ Validation failed for PR #${env.CHANGE_ID}" :
          "❌ Deployment failed for branch ${env.BRANCH_NAME}"
        echo msg
        emailext(
          subject: "Jenkins Build FAILED: #${env.BUILD_NUMBER}",
          body: """<p>${msg}</p>
                   <p>Check logs in your dashboard.</p>""",
          to: "dheeraj.pvas@gmail.com"
        )
      }
    }
  }
}
