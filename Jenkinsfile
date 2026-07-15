pipeline {
    agent any
    environment {
        // These map to the exact Secret Text IDs you create in Step 3
        ARM_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        ARM_TENANT_ID       = credentials('AZURE_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init -no-color'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan -no-color'
            }
        }
        stage('Terraform Apply') {
            steps {
                // Remove -auto-approve in production to require human validation
                sh 'terraform apply -auto-approve tfplan -no-color'
            }
        }
    }
}
