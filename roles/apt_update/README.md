# apt_update

Updates the APT package cache and performs a full distribution upgrade on the target host.

## What it does

Runs `apt-get update` and `apt-get dist-upgrade` in a single task using the `ansible.builtin.apt` module. This ensures all installed packages are up to date before other roles install software.

## Requirements

- Target host must be Debian/Ubuntu.
- Role must run with privilege escalation (`become: true`).

## Example

```yaml
- hosts: all
  become: true
  roles:
    - apt_update
```
