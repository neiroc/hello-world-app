# challenge-cubbit

[Read the Challenge](./DevOps-Cubbit-Task.pdf)


Per il provisioning delle VM  è stato scelto `Terraform` e  `Google Cloud` come provider. 

È stata inserita in maniera automatica la chiave rsa pubblica `cubbit.pub` su ognuna delle VM per un accesso `ssh` veloce, semplificato e sicuro.


--- 

## Come utilizzare questo progetto

### Terraform - Provisioning VM

Per inizializzare terraform

```bash
terraform init 
```

Per applicare i manifest

```bash
terraform apply
```

Per distruggere l'ambiente

```bash
terraform destroy
```

## Ansible - Configure & Install k8s

- Inserire gli indirizzi IP pubblici nel file di inventario

- Inserire l'indirizzo pubblico del control plane in `ansible/playbooks/install.yaml` per generare un certificato con SAN aggiuntiva

`kubernetes_kubeadm_init_extra_opts: "--apiserver-cert-extra-sans=<cotrol_plane_public_ip>"`


1. Configure VM

This playbook will prepare the VM to be ready to install Kubernetes

```bash
ansible-playbook -i hosts playbooks/configure.yaml -u justanotherwop 
```

2. Install k8s

This playbook will install Kubernetes with the `kubeadm` approach using this [role](https://github.com/geerlingguy/ansible-role-kubernetes)

```bash
ansible-playbook -i hosts playbooks/install.yaml -u justanotherwop
```

