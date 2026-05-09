# consul

Installs [Consul](https://developer.hashicorp.com/consul/docs) via APT.

## What it does

Installs the `consul` package using `ansible.builtin.apt`. Requires the Hashicorp APT repository to already be configured on the host (see the `apt_repo` role).

## Requirements

- The `apt_repo` role must have run first to add the Hashicorp APT repository.
- Target host must be Debian/Ubuntu.
- Role must run with privilege escalation (`become: true`).

## Example

```yaml
- hosts: all
  become: true
  roles:
    - apt_repo
    - apt_update
    - consul
```
