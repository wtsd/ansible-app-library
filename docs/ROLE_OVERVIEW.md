# Role Overview

- `common_base`: base packages, time sync, user/group, log dir, optional node_exporter.
- `firewall`: firewalld + open common ports.
- `nginx`: basic reverse proxy routing to `/py/` and `/java/` paths.
- `python_app`: venv + gunicorn systemd service + repo checkout.
- `java_app`: installs JDK and manages a JAR as a systemd service.
- `hardening_basics`: minimal SSH+sudo guardrails.
