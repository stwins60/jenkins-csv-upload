pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    environment {
        S3_BUCKET = "s3://JENKINS-CSV-UPLOAD-10-08"
    }
    stages {
        stage('Git Clone') {
           steps{
                git "https://github.com/stwins60/jenkins-csv-upload.git"
            }
        }

        stage('Check if s3 bucket exists') {
            steps {
                script {
                    def s3BucketExists = sh(returnStdout: true, script: "aws s3 ls ${S3_BUCKET}").trim()
                    if (s3BucketExists == "") {
                        bat "aws s3 mb ${S3_BUCKET}"
                    }
                    else {
                        bat "aws s3 rm ${S3_BUCKET} --recursive"
                    }
                }
            }
        }
        stage('terraform format check') {
            steps{
                bat 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                bat 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                script {
                    if (params.env == 'test'){
                        echo 'deploying on test'
                        bat 'terraform apply s3/test --auto-approve'
                    }
                    if (params.env == 'dev'){
                        echo 'deploying on dev'
                        bat 'terraform apply s3/dev --auto-approve'
                    }
                    if (params.env == 'prod'){
                        echo 'deploying on prod'
                        bat 'terraform apply s3/prod --auto-approve'
                    }
                }
                // bat 'terraform apply s3/test --auto-approve'
            }
        }
        stage("Upload CSV file to S3 with timestamp") {
            steps {
                script {
                    def timestamp = sh(returnStdout: true, script: "date +%Y-%m-%d-%H-%M-%S").trim()
                    bat "aws s3 cp ${files.csv} ${S3_BUCKET}/files-${timestamp}.csv"
                }
            }
        }
    }

    
}
