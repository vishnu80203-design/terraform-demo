pipeline {
    agent any 

    environment {
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Terraform Execution') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'azure-sp-credentials', 
                                                       clientIdVariable: 'ARM_CLIENT_ID', 
                                                       clientSecretVariable: 'ARM_CLIENT_SECRET', 
                                                       subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', 
                                                       tenantIdVariable: 'ARM_TENANT_ID')]) {
                    
                    echo "Initializing Terraform..."
                    sh 'terraform init -no-color'

                    echo "Planning changes..."
                    sh 'terraform plan -out=tfplan -no-color'

                    echo "Applying exact plan to Azure..."
                    sh 'terraform apply -input=false tfplan -no-color'
                }
            }
        }
    }
}
