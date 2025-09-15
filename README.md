# Ansible App Library

Reusable Ansible roles and playbooks for deploying **Python** and **Java** applications
on **CentOS** / **Oracle Linux** servers across **AWS** and **GCP**. Includes optional
provisioning with **Terraform** (AWS+GCP) and **CloudFormation** (AWS).

> Designed to be copy‑pasted or used as a starting template for real projects.
> Minimal external dependencies and cloud‑native inventory plugins.

---

## Highlights
- **Roles** for common app patterns: Python app (venv + systemd + nginx), Java app (jar/war + systemd + nginx)
- **OS support**: CentOS, Oracle Linux (dnf/yum automatically detected)
- **Clouds**: AWS & GCP dynamic inventory examples, tags-first grouping, per‑env vars (dev, qa, staging, prod)
- **Security**: basic hardening, firewall (firewalld), limited sudo, ssh config
- **Observability**: optional `node_exporter` role and log directory rotation
- **Infra**: Terraform modules to spin up EC2 / GCE instances; CloudFormation template (very basic)
- **CI**: GitHub Actions for linting (`ansible-lint`, `yamllint`).

## Quick start
```bash
# 1) Install requirements
pipx install ansible-core ansible-lint yamllint
ansible-galaxy collection install -r collections/requirements.yml

# 2) Set inventory (choose one)
## clone repo
## edit group_vars/host_vars as needed
cp -r inventories/sample inventories/dev    

# or use cloud inventories:
# AWS:  ansible-inventory -i inventories/aws/aws_ec2.yml --graph
# GCP:  ansible-inventory -i inventories/gcp/gcp_compute.yml --graph

# 3) Run a sample deployment to a host group
ansible-playbook -i inventories/dev/hosts.ini playbooks/deploy_python_app.yml -l app

# or
ansible-playbook -i inventories/dev/hosts.ini playbooks/deploy_java_app.yml -l app
```

## Repository layout
```
ansible-app-library/
  playbooks/                  # Thin playbooks that compose roles
  roles/                      # Reusable roles
  inventories/                # Static + dynamic inventory examples (AWS/GCP)
  group_vars/ & host_vars/    # Shared variables examples
  collections/                # Galaxy collections requirements
  docs/                       # How‑to and design docs
  infra/                      # Terraform and CloudFormation provisioning
```

