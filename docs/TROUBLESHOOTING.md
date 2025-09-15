# Troubleshooting

- **SELinux**: On OL/CentOS, ensure SELinux contexts for `/opt/apps` or disable for quick tests:
  `setenforce 0` (temporary). Prefer setting proper contexts with `semanage fcontext`.
- **Firewalld**: If ports are blocked, check `firewall-cmd --list-ports`.
- **Systemd**: `journalctl -u <service> -f` for live logs.
- **Python**: If distro lacks `python3.10` package, use software collections or compile; or set `python_version` to a distro-provided one (e.g., 3.9 on OL8/OL9).
- **Dynamic inventory**: Validate with `ansible-inventory ... --list` and `--graph`.
