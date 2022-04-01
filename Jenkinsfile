pipeline {
    agent any
    tools{
       terraform 'my_terraform'
    }
    stages {
       stage('Terraform Init') {
            steps {
                sh label: '', script: 'terraform init'
            }
        }
        stage('Terraform apply') {
            steps {
            sh label: '', script: 'terraform apply --auto-approve'
            }
       }
    }
}
