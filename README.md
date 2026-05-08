# Nomaduntu

<img src="logo.png" alt="Nomaduntu Logo" width="200" height="225"  />

An Ansible playbook for deploying [Nomad](https://developer.hashicorp.com/nomad/docs) + [Consul](https://developer.hashicorp.com/consul/docs) on an Ubuntu cluster.

**[Nomad](https://developer.hashicorp.com/nomad/docs)** is a workload orchestrator by HashiCorp. It schedules and runs containerised and bare-metal applications across a cluster of machines, similar in spirit to Kubernetes but simpler to operate.

**[Consul](https://developer.hashicorp.com/consul/docs)** is a service mesh and service discovery tool, also by HashiCorp. It provides a distributed key-value store, health checking, and DNS-based service discovery. Nomad integrates with Consul natively to handle cluster membership and service registration.

## Requirements

- Ansible installed on the control machine
- Target hosts running Ubuntu (22.04 LTS or later)
- SSH access to all hosts in the inventory

## Inventory

Hosts are organised into named groups; the group name becomes the Consul/Nomad [**datacenter**](https://developer.hashicorp.com/consul/docs/reference/agent/configuration-file/general#datacenter) for every host in that group.

**Host variables:**

| Variable | Values | Purpose |
|---|---|---|
| `server.enabled` | `true` / _(absent)_ | Configures the host as a Nomad/Consul server |

Example host definition:

```yaml
node1.example.com:
  server:
    enabled: true

node2.example.com: {}
node3.example.com: {}
```

## Running the playbook

Run a full deployment:

```zsh
ansible-playbook -i inventory/hosts.yml playbooks/nomaduntu.yml
```

To limit execution to a single host or group:

```zsh
ansible-playbook -i inventory/hosts.yml playbooks/nomaduntu.yml --limit <hostname>
```

## What it does

For every host, the playbook performs the following steps:

1. **Facts** — asserts the host is running Ubuntu and sets the `datacenter` fact derived from the host's inventory group name.
2. **Consul** — creates config/data directories, installs Consul via the HashiCorp apt repository, templates [`server.hcl`](https://developer.hashicorp.com/consul/docs/reference/agent/configuration-file) with datacenter, node name, server/client mode, and [`retry_join`](https://developer.hashicorp.com/consul/docs/reference/agent/configuration-file/general#retry_join) derived from inventory, and registers a systemd service.
3. **Nomad** — creates config/data directories, installs Nomad via the HashiCorp apt repository, templates [`server.hcl`](https://developer.hashicorp.com/nomad/docs/configuration) (including [`bootstrap_expect`](https://developer.hashicorp.com/nomad/docs/configuration/server#bootstrap_expect) and [`retry_join`](https://developer.hashicorp.com/nomad/docs/configuration/server_join)), and registers a systemd service.

Services are managed as systemd units (Nomad and Consul).

## Remarks

- **Platform** — This playbook is tested against Ubuntu 24.04 LTS. Other Ubuntu versions may work but are untested.
- **Companion project** — [Nomadintosh](https://github.com/anultravioletaurora/Nomadintosh) is the macOS counterpart to this playbook. Nomad's multi-platform support means both clusters can participate in the same datacenter if desired.
