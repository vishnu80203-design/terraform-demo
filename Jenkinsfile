pipeline {
    agent any 
    
    environment {
        TF_IN_AUTOMATION = 'true'
    }
    
    stages {
        stage('Terraform Execution') {
            steps {
                // This correctly binds your Jenkins credential to the exact variables Terraform requires
                withCredentials([azureServicePrincipal(credentialsId: 'azure-sp-credentials', 
                                                       clientIdVariable: 'ARM_CLIENT_ID', 
                                                       clientSecretVariable: 'ARM_CLIENT_SECRET', 
                                                       subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', 
                                                       tenantIdVariable: 'ARM_TENANT_ID')]) {
                    
                    echo "Initializing Terraform..."
                    sh 'terraform init -no-color'

                    echo "Planning changes..."
                    // Forces Terraform to save the exact calculation
                    sh 'terraform plan -out=tfplan -no-color'

                    echo "Applying exact plan to Azure..."
                    // Applies the saved file. No --auto-approve needed when passing a plan file.
                    sh 'terraform apply -input=false tfplan -no-color'
                }
            }
        }
    }
}
