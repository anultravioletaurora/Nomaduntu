# apt_repo

Adds the Hashicorp APT repository to an Ubuntu host so that packages like Consul and Nomad can be installed via `apt`.

## What it does

1. Downloads the Hashicorp GPG signing key to `/usr/share/keyrings/hashicorp-archive-keyring.gpg`.
2. Detects the host's dpkg architecture (e.g. `amd64`, `arm64`) using `dpkg --print-architecture`.
3. Adds the Hashicorp APT repository to `/etc/apt/sources.list.d/`, referencing the key via `signed-by=`.

This matches the [official Hashicorp installation instructions](https://developer.hashicorp.com/nomad/install) and uses the modern `signed-by` approach rather than the deprecated global keyring.

## Defaults

| Variable | Default | Description |
|---|---|---|
| `apt_repo_gpg_key_url` | `https://apt.releases.hashicorp.com/gpg` | URL of the Hashicorp GPG key |

## Requirements

- Target host must be Debian/Ubuntu with `dpkg` and `lsb_release` available.
- Role must run with privilege escalation (`become: true`).

## Example

```yaml
- hosts: all
  become: true
  roles:
    - apt_repo
```
