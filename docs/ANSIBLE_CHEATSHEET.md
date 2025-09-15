# Ansible Cheatsheet

## Basic Concepts
- **Inventory**: Defines hosts and groups (`/etc/ansible/hosts` or custom file with `-i`)
- **Playbook**: YAML file with tasks to execute on hosts
- **Module**: Pre-built units of work (e.g., `apt`, `copy`, `service`)
- **Role**: Reusable collection of tasks, templates, and files
- **Ad-hoc Commands**: Single tasks run via `ansible` command

## Common Commands
- **Ad-hoc command**:
  ```bash
  ansible <host-pattern> -m <module> -a "<arguments>" [-i inventory] [-u user]
  ```
  Example: `ansible webservers -m ping`
- **Run playbook**:
  ```bash
  ansible-playbook playbook.yml [-i inventory] [-e "extra_vars"]
  ```
- **Check playbook syntax**:
  ```bash
  ansible-playbook playbook.yml --syntax-check
  ```
- **Dry run (check mode)**:
  ```bash
  ansible-playbook playbook.yml --check
  ```
- **List hosts in inventory**:
  ```bash
  ansible all --list-hosts
  ```

## Inventory File Example
```ini
[webservers]
web1.example.com ansible_host=192.168.1.10
web2.example.com ansible_host=192.168.1.11

[db]
db1.example.com ansible_host=192.168.1.20

[all:vars]
ansible_user=admin
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## Playbook Structure
```yaml
---
- name: Example playbook
  hosts: webservers
  become: yes  # Run as sudo
  vars:
    http_port: 80
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present
    - name: Start Apache
      service:
        name: apache2
        state: started
        enabled: yes
```

## Common Modules
- **Package management**:
  - `apt`: `ansible webservers -m apt -a "name=nginx state=present"`
  - `yum`: `ansible webservers -m yum -a "name=httpd state=latest"`
- **File operations**:
  - `copy`: Copy files to remote hosts
    ```yaml
    - copy:
        src: /local/file.conf
        dest: /etc/file.conf
        mode: '0644'
    ```
  - `template`: Copy Jinja2 templates
    ```yaml
    - template:
        src: templates/config.j2
        dest: /etc/config.conf
    ```
- **Service management**:
  - `service`: Manage services
    ```yaml
    - service:
        name: nginx
        state: restarted
    ```
- **User management**:
  - `user`: Manage users
    ```yaml
    - user:
        name: johndoe
        state: present
        password: "{{ 'mypassword' | password_hash('sha512') }}"
    ```

## Variables
- Define in playbooks:
  ```yaml
  vars:
    app_version: 1.2.3
  ```
- Use in tasks:
  ```yaml
  - name: Install specific version
    apt:
      name: "myapp={{ app_version }}"
      state: present
  ```
- Extra vars from CLI:
  ```bash
  ansible-playbook playbook.yml -e "app_version=1.2.3"
  ```

## Conditionals
```yaml
- name: Install package on Ubuntu
  apt:
    name: nginx
    state: present
  when: ansible_distribution == "Ubuntu"
```

## Loops
```yaml
- name: Install multiple packages
  apt:
    name: "{{ item }}"
    state: present
  loop:
    - nginx
    - curl
    - vim
```

## Roles
- Directory structure:
  ```
  roles/
    myrole/
      tasks/
        main.yml
      templates/
      files/
      vars/
      defaults/
  ```
- Use in playbook:
  ```yaml
  - hosts: webservers
    roles:
      - myrole
  ```

## Debugging
- **Verbose output**:
  ```bash
  ansible-playbook playbook.yml -v  # or -vv, -vvv
  ```
- **Debug module**:
  ```yaml
  - debug:
      msg: "Value of variable is {{ my_var }}"
  ```

## Vault (Encrypting Secrets)
- Create encrypted file:
  ```bash
  ansible-vault create secret.yml
  ```
- Edit encrypted file:
  ```bash
  ansible-vault edit secret.yml
  ```
- Run playbook with vault:
  ```bash
  ansible-playbook playbook.yml --ask-vault-pass
  ```

## Best Practices
- Use roles for modularity
- Keep inventory organized
- Use `become` for privilege escalation
- Validate playbooks with `--syntax-check` and `--check`
- Use vault for sensitive data
- Document tasks with meaningful `name` fields