#! /bin/zsh

# Run Nomadintosh in check mode
ansible-playbook playbooks/nomaduntu.yml --check --diff
