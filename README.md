# Homelab Deployment

This is a set of playbooks and terraform modules to build out my kubernetes homelab from scratch. This started out with a mess of very basic shell scripts running terraform and kubectl commands. Variables were not broken out either. This will be the end result of cleaning everything up and splitting variables and secrets out properly. Once the base level is set, I will begin migrating over other workloads into this with the end goal of moving most of my homelab into kubernetes.

One of the reasons for using Ansible as a wrapper around Terraform is the need to modify a PanOS firewall for the K8s cluster. This uses metallb with BGP to the PanOS firewall. Terraform's PanOS module doesn't have support for committing changes and rolling back if needed.

## Terraform Variables

For now this is using a bit of a hack, Terraform variables are populated in a Jinja2 template `files/terraform-var-file.j2`. This idea came from a GitHub issue with the Ansible Terraform module. You can't send an Ansible variable over and have it escaped correctly if it contains lists or dictionaries.

[Source issue](https://github.com/ansible/ansible/issues/51687)

## Misc

Still have a lot of cleanup of existing configs. Sprinkled some `TODO` comments for things to change.

Major tasks left:

- [ ] Support workspaces
- [ ] Support remote state
- [ ] Work out PanOS change management
- [ ] Utilize netbox for variables for specific instances
