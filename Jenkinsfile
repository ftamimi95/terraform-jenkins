pipeline {
    
    agent {
            label 'master'
        }
    tools {
        terraform 'terraform-1-1-7'
    }
    parameters {
        string(name: 'GCP_PROJECT_ID', defaultValue: 'astute-veld-344810', description: 'GCP Project ID',)
        string(name: 'CLOUD_SQL_NAME', defaultValue: 'sql-db-test', description: 'Cloud SQL Instance name',)
        string(name: 'CLOUD_SQL_VERSION', defaultValue: 'MYSQL_8_0', description: 'Cloud SQL Instance name',)
        string(name: 'GCP_REGION', defaultValue: 'us-central1', description: 'GCP Region',)
        string(name: 'INSTANCE_TYPE', defaultValue: 'REGIONAL', description: 'Instance type or tier',)
        // string(name: 'GCP_ZONE', defaultValue: 'us-central1-a', description: 'Zone selection if needed',)
        // string(name: 'GCP_ACTIVATION_POLICY', defaultValue: 'xxx', description: 'server hostname',)
        // string(name: 'GCP_AVAILABILITY_TYPE', defaultValue: 'xxx', description: 'The availability type for the master instance. Can be either `REGIONAL` or `null`',)
        // string(name: 'DISK_AUTO_RESIZE', defaultValue: 'xxx', description: 'Enable Auto Resize for the disk',)
        // string(name: 'INSTANCE_DISK_SIZE', defaultValue: "10", description: 'Initial disk size',)
        // string(name: 'INSTANCE_DISK_TYPE', defaultValue: 'xxx', description: 'Instance disk type',)
    }
    stages {
        
        stage('Clone Repo'){
            steps{
                // git branch: 'terraform-test-branch', url: 'https://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@github.com/ftamimi95/terraform-gcp-cloud-sql-jenkins.git'
            
                sh 'ls -ltr'
            }
        }
        
        stage('GCloud Login'){
            steps{
                withCredentials([file(credentialsId: 'terraform-svc', variable: 'GC_KEY')]) {
                sh("gcloud auth activate-service-account --key-file=${GC_KEY}")
                }   
            }
        }
        
        // stage('plan-test'){
        //     steps{
        //         // sh 'cd ${workspace}/example/'
        //         sh 'pwd'
        //         sh 'terraform plan -f example.tf'
        //     }
        // }
        
        stage('Terraform Plan') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform init'
                    sh '''terraform plan \
                    -var 'project_id=${GCP_PROJECT_ID}' \
                    -var 'name=sql-db-test' \
                    -var 'database_version=$(DATABASE_VERSION)' \
                    -var 'region=${GCP_REGION}'\
                    -var 'tier=${INSTANCE_TYPE}' \
                    -var 'disk_size=10' \
                    -var 'zone=${GCP_ZONE}' \
                    -var 'database_version=${CLOUD_SQL_VERSION}' '''
                    // 
                    // -var 'activation_policy=$(GCP_ACTIVATION_POLICY)' \
                    // -var 'availability_type=$(GCP_AVAILABILITY_TYPE)' \
                    // -var 'disk_autoresize=$(DISK_AUTO_RESIZE)' \
                    // -var 'disk_size=$(INSTANCE_DISK_TYPE)'
                    //-var 'tags={ "Owner":"$(OWNER)", "Service":"$(SERVICE)", "Terraform":"true", "Env":"$(ENV)" }'
                } 
            }
        }
        stage('Terraform Apply') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh '''terraform apply -input=false -auto-approve \
                    -var 'project_id=${GCP_PROJECT_ID}' \
                    -var 'name=sql-db-test' \
                    -var 'database_version=$(DATABASE_VERSION)' \
                    -var 'region=${GCP_REGION}'\
                    -var 'tier=${INSTANCE_TYPE}' \
                    -var 'disk_size=10' \
                    -var 'zone=${GCP_ZONE}' \
                    -var 'database_version=${CLOUD_SQL_VERSION}' '''
                    // -var 'activation_policy=$(GCP_ACTIVATION_POLICY)' \
                    // -var 'availability_type=$(GCP_AVAILABILITY_TYPE)' \
                    // -var 'disk_autoresize=$(DISK_AUTO_RESIZE)' \
                    // -var 'disk_size=$(INSTANCE_DISK_TYPE)'
                    //-var 'tags={ "Owner":"$(OWNER)", "Service":"$(SERVICE)", "Terraform":"true", "Env":"$(ENV)" }'
                } 
            }
        }
    }
}