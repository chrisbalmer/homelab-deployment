# Homelab Deployment

This is a set of playbooks and terraform modules to build out my kubernetes homelab from scratch. This started out with a mess of very basic shell scripts running terraform and kubectl commands. Variables were not broken out either. This will be the end result of cleaning everything up and splitting variables and secrets out properly. Once the base level is set, I will begin migrating over other workloads into this with the end goal of moving most of my homelab into kubernetes.

One of the reasons for using Ansible as a wrapper around Terraform is the need to modify a PanOS firewall for the K8s cluster. This uses metallb with BGP to the PanOS firewall. Terraform's PanOS module doesn't have support for committing changes and rolling back if needed.

## Terraform Variables

~~For now this is using a bit of a hack, Terraform variables are populated in a Jinja2 template `files/terraform-var-file.j2`. This idea came from a GitHub issue with the Ansible Terraform module. You can't send an Ansible variable over and have it escaped correctly if it contains lists or dictionaries.~~

~~[Source issue](https://github.com/ansible/ansible/issues/51687)~~

I changed this to build out a custom Terraform HCL file for the nodes as I could not do a loop with the nodes module in Terraform and to keep it DRY, it made more sense to template the HCL file with Jinja2. This will be removed if they enable looping in Terraform for modules but so far it looks like it is a far off feature.

[Source issue](https://github.com/hashicorp/terraform/issues/953)

After running the Terraform apply or destroy, the custom file is removed to avoid secrets being left in plaintext.

## Inventory

The Ansible inventory has finally been moved to a proper dynamic script which loads the data from the Terraform group variables file and then generates an inventory for Ansible. This was another step to keep things DRY.

## Misc

Still have a lot of cleanup of existing configs. Sprinkled some `TODO` comments for things to change.

Major tasks left:

- [X] Fix DNS on nodes when deploying, unsure if issue is in the image or the deployment
    - Issue was due to missing the config in the network template for cloud-init
- [X] Switch to a dynamic inventory
- [ ] Support workspaces
- [ ] Support remote state
- [ ] Work out PanOS change management
- [ ] Utilize netbox for variables for specific instances
- [ ] Add RKE configs to build out the k8s cluster
- [ ] Add PanOS configs for BGP with k8s cluster
- [ ] Add MetalLB manifests for BGP with PanOS
- [ ] Bootstrap initial accounts similar to [this reddit post](https://www.reddit.com/r/ansible/comments/cz3hxp/how_to_make_ansible_connect_as_root_using_a_ssh/eyvx6ar/)
