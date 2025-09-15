# Using AWS & GCP Inventories

## AWS
1. Configure credentials (`aws configure`) or env vars.
2. Install collections: `ansible-galaxy collection install -r collections/requirements.yml`.
3. Edit `inventories/aws/aws_ec2.yml` regions/filters.
4. Try:
   ```bash
   ansible-inventory -i inventories/aws/aws_ec2.yml --graph
   ansible-playbook -i inventories/aws/aws_ec2.yml playbooks/hardening.yml -l role_app
   ```

## GCP
1. Create a service account with Compute Viewer and read access.
2. Download key JSON to `~/.gcp/service-account.json`.
3. Edit `inventories/gcp/gcp_compute.yml` project/zones.
4. Run:
   ```bash
   ansible-inventory -i inventories/gcp/gcp_compute.yml --graph
   ansible-playbook -i inventories/gcp/gcp_compute.yml playbooks/deploy_python_app.yml -l role_app
   ```
