pipeline {
    agent any
    environment {
        // This maps Jenkins credentials straight into Terraform variables
        AZURE_CREDS = credentials('azure-sp-credentials')
    }
    stages {
        stage('Terraform Init & Apply') {
            steps {
                withCredentials([azureServicePrincipal('azure-sp-credentials')]) {
                    // Set up environment variables that Terraform automatically reads for auth
                    env.ARM_CLIENT_ID       = "$AZURE_CLIENT_ID"
                    env.ARM_CLIENT_SECRET   = "$AZURE_CLIENT_SECRET"
                    env.ARM_TENANT_ID       = "$AZURE_TENANT_ID"
                    env.ARM_SUBSCRIPTION_ID = "$AZURE_SUBSCRIPTION_ID"

                    echo "Initializing Terraform..."
                    sh 'terraform init'

                    echo "Planning changes..."
                    sh 'terraform plan'

                    echo "Applying changes to Azure..."
                    // --auto-approve skips the manual "yes" confirmation prompt
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }
}