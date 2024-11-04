# Ansible - Install k3s 

This Ansible project is going to install `k3s`

## Utilizzo dei ruoli e dei playbook

Ping VM

```bash
ansible all -i inventory.yml -u justanotherwop  -m ping -v
```

Other options:

`-k` ask for connection password
`-K` ask for privilege escalation password

NOTA. (Se necessario) Installare i requirements con il seguente comando:

```bash
ansible-galaxy install -r requirements.yml 
```

Esegui un check prima di eseguire un playbook

```bash
ansible-playbook -i inventory.yml playbooks/site.yml --check
```

Per lanciare i playbook utilizzare il seguente comando:

```bash
ansible-playbook -i inventory.yml playbooks/site.yml 
```

dove 

- `-u USER` indica con quale utente si fa il login via ssh agli host (generalmente il proprio utente LDAP);
- `-k` mostra il prompt per inserire la password ssh;
- `-K` quello per inserire la password di sudo.

**Nota**: se sulle macchine di destinazione è presente la chiave ssh il playbook si blocca sulla fase "Gathering Facts", perché utilizza sshpass per collegarsi. Rimuovere l'opzione `-k` in modo che venga mostrato il prompt per l'inserimento della passphrase.
