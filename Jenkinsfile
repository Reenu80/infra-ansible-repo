pipeline {
    agent any

    stages {

        stage('Clone Repo') {
            steps {
                git 'https://github.com/Reenu80/infra-ansible-repo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

       stage('Generate Ansible Inventory') {
    steps {
        script {
            def ips = sh(
                script: "cd terraform && terraform output -json private_ips | jq -r '.[]'",
                returnStdout: true
            ).trim()

            def formattedIps = ips.split("\n").collect { ip ->
                "${ip} ansible_user=ubuntu"
            }.join("\n")

            writeFile file: "ansible/inventory/hosts.ini", text: """
[webservers]
${formattedIps}
"""
        }
    }
}


      stage('Run Ansible Playbook') {
    steps {
        dir('ansible') {
            sh 'ansible-playbook -i inventory/hosts.ini deploy.yml --private-key /var/lib/jenkins/25-nov-25-thinkpadoff.pem'
        }
    }
}
