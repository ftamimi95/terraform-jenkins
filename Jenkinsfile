pipeline {
    
    agent {
            label 'master'
        }
    tools {
        terraform 'terraform-1-1-7'
    }
    parameters {
        string(name: 'GCP_PROJECT_ID', defaultValue: 'xxx', description: 'GCP Project ID',)
        string(name: 'CLOUD_SQL_NAME', defaultValue: 'xxx', description: 'Cloud SQL Instance name',)
        string(name: 'GCP_REGION', defaultValue: 'xxx', description: 'GCP Region',)
        string(name: 'INSTANCE_TYPE', defaultValue: 'xxx', description: 'Instance type or tier',)
        // string(name: 'GCP_ZONE', defaultValue: 'xxx', description: 'Zone selection if needed',)
        // string(name: 'GCP_ACTIVATION_POLICY', defaultValue: 'xxx', description: 'server hostname',)
        // string(name: 'GCP_AVAILABILITY_TYPE', defaultValue: 'xxx', description: 'The availability type for the master instance. Can be either `REGIONAL` or `null`',)
        // string(name: 'DISK_AUTO_RESIZE', defaultValue: 'xxx', description: 'Enable Auto Resize for the disk',)
        string(name: 'INSTANCE_DISK_SIZE', defaultValue: 'xxx', description: 'Initial disk size',)
        // string(name: 'INSTANCE_DISK_TYPE', defaultValue: 'xxx', description: 'Instance disk type',)
    }
    stages {
        stage('prepare') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform init'
                    sh '''terraform plan \
                    -var 'project_id=$(GCP_PROJECT_ID)' \
                    -var 'name=$(CLOUD_SQL_NAME)' \
                    -var 'database_version=$(DATABASE_VERSION)' \
                    -var 'region=$(GCP_REGION)'\
                    -var 'tier=$(INSTANCE_TYPE)' \
                    -var 'disk_size=$(INSTANCE_DISK_SIZE)' ''' 
                    // -var 'zone=$(GCP_ZONE)' \
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