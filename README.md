README
=======

Versions
=======

- packer 1.0.3
- ansible 2.3.1.0

Environments
=======
- Set AWS Keys to local environments
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

- Set GCP Service Account and Project ID to local environments
  - GOOGLE_APPLICATION_CREDENTIALS
  - GCLOUD_PROJECT

Execute
=======
Packer
  - AWS
    - packer build builders/aws/webserver.json
  - Docker
    - packer build builders/docker/webserver.json
  - Docker
    - packer build builders/gcp/webserver.json

Ansible
  - ansible-playbook -i inventories/development/hosts site.yml
