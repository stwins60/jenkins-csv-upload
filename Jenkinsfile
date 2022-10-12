pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    environment {
        S3_BUCKET = "s3://vivians3bucket1007"
    }
    stages {
        stage('Git checkout') {
           steps{
                git branch: 'main', credentialsId: 'Github', url: 'https://github.com/stwins60/jenkins-csv-upload'
            }
        }

        stage('Check if s3 bucket exists') {
            steps {
                script {
                    def s3BucketExists = sh(returnStdout: true, script: "aws s3 ls ${S3_BUCKET}").trim()
                    if (s3BucketExists == "") {
                        sh "aws s3 mb ${S3_BUCKET}"
                    }
                    else {
                        sh "aws s3 rm ${S3_BUCKET} --recursive"
                    }
                }
            }
        }
        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }

    
}