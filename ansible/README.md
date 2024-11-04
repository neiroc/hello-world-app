# Ansible - Install k3s 

This Ansible project is going to install `k3s`.

## Using roles and playbooks

Ping VM

```bash
ansible all -i inventory.yml -u justanotherwop -m ping -v
```

Other options:

`-k` ask for connection password
`-K` ask for privilege escalation password

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
