# Dev Guide

- Edit `group_vars/*` and `inventories/*` to reflect your environment.
- For AWS/GCP, ensure credentials are available to the inventory plugin (env vars or config files).
- Use tags in AWS (Env, Role) or labels in GCP (env, role) to group hosts automatically.
- Run `ansible-playbook --check --diff` in CI first, then run normally.

## Typical flows
- Spin infra with Terraform in `infra/terraform/aws` or `infra/terraform/gcp` then run Ansible:
  ```bash
  cd infra/terraform/aws && terraform init && terraform apply -auto-approve
  # outputs include an Ansible inventory file you can pass with -i
  ansible-playbook -i ./generated_inventory.ini ../../playbooks/deploy_python_app.yml
  ```
