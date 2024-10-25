# challenge-cubbit

[Read the Challenge]()


Per il provisioning delle VM  è stato scelto `Terraform` e  `Google Cloud` come provider. 

È stata inserita in maniera automatica la chiave rsa pubblica `cubbit.pub` su ognuna delle VM per un accesso `ssh` veloce, semplificato e sicuro.




Riepilogando:

- Provisioning VM, creazione namespace: Terraform
- Benchmark, configurazione VM, installazione k8s: Ansible
- Installazione e aggiornamento Applicativi: Helm
- Liniting: tflint (terraform), ansible-lint (Ansible)

### Links

- https://github.com/geerlingguy/ansible-role-kubernetes
- https://github.com/aquasecurity/kube-bench
- https://github.com/terraform-linters/tflint
- https://github.com/ansible/ansible-lint

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

- Inserire gli indirizzi IP pubblici nel file di inventario Ansible `hosts`

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


3. Benchmark

This playbook will generate a security audit 

```bash
ansible-playbook -i hosts playbooks/benchmark.yaml -u justanotherwop
```

To check te output: `cat cat /var/log/kube-bench.log`

## Install Application with Helm

See: https://github.com/bitnami/charts/tree/main/bitnami/wordpress/

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-wordpress bitnami/wordpress --version "15.0.4" -f custom-values.yaml 
```

 > To update WordPress core, we recommend you use the helm upgrade command to update your deployment instead of using the built-in update functionality.