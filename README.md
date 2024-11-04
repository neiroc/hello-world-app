# Cubbit Challenge

[Read the Challenge](./DevOps-Cubbit-Task.pdf)

## Key design decisions

- Infrastructure as Code: `Terraform`
- Cloud Provider: `Google Cloud`
- k3s installation: `Ansible`

--- 

## How to use this project

### IaC - Terraform

To provision the VM.

From this directory root

```bash
cd terraform
```

Init 

```bash
terraform init 
```

Apply

```bash
terraform apply
```

To destroy the environment

```bash
terraform destroy
```

## Automation - Ansible

From this directory root

```bash
cd ansible
```

Insert the public IP of the VM in `inventory.yml`

Ping VM

```bash
ansible all -i inventory.yml -u justanotherwop -m ping -v
```

1. Configure VM

This playbook will prepare the VM to be ready to install Kubernetes

```bash
ansible-playbook -i hosts playbooks/configure.yaml -u justanotherwop 
```

NOTE. (If necessary) Install the requirements with the following command:

```bash
ansible-galaxy install -r requirements.yml 
```

Run a check before running a playbook

```bash
ansible-playbook -i inventory.yml playbooks/site.yml --check
```

To run playbooks use the following command:

```bash
ansible-playbook -i inventory.yml playbooks/site.yml 
```

## Deploy 

After installing the k3s cluster, to deploy the application, simply push a change to the github repository to start the CI/CD pipeline that will perform the update to the latest release

