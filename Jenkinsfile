pipeline {
    agent any 

    environment {
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Terraform Execution') {
            steps {
                // Injects your AWS credentials securely into the environment
                withCredentials([aws(credentialsId: 'AWS creds', 
                                     accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    
                    echo "Initializing AWS Terraform..."
                    sh 'terraform init -no-color'

                    echo "Planning AWS infrastructure..."
                    sh 'terraform plan -out=tfplan -no-color'

                    echo "Applying exact plan to AWS..."
                    sh 'terraform apply -input=false tfplan -no-color'
                }
            }
        }
    }
}
