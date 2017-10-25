README
=======

Versions
=======

- packer 1.0.3
- ansible 2.3.1.0
- Terraform 0.10.7

Environments
=======
- Set AWS Keys to local environments
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

- Set GCP Service Account and Project ID to local environments
  - GOOGLE_APPLICATION_CREDENTIALS
  - GCLOUD_PROJECT

Target OS
======
- CentOS7, 6 and Amazon Linux

Execute
=======
Terraform
  - GCP:
    - terraform plan -var 'image=[image name]' -out=terraform/providers/google/gce.plan terraform/providers/google/
    - terraform apply terraform/providers/google/gce.plan

Packer
  - AWS: packer build builders/aws/webserver.json
  - Docker: packer build builders/docker/webserver.json
  - GCP: packer build builders/gcp/webserver.json

  - Get created image name
    - packer build -machine-readable builders/gcp/webserver.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'

Ansible
  - ansible-playbook -i inventories/development/hosts site.yml
