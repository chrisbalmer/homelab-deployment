data "vsphere_datacenter" "node_dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_compute_cluster" "node_cluster" {
  name          = "${var.vsphere_cluster}"
  datacenter_id = "${data.vsphere_datacenter.node_dc.id}"
}

data "vsphere_resource_pool" "node_pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.node_dc.id}"
}

data "vsphere_datastore" "node_datastore" {
  datacenter_id = "${data.vsphere_datacenter.node_dc.id}"
  name          = "${var.vsphere_datastore}"
}

data "vsphere_network" "node_network" {
  datacenter_id = "${data.vsphere_datacenter.node_dc.id}"
  name          = "${var.vsphere_network}"
}

data "vsphere_virtual_machine" "node_template" {
  datacenter_id = "${data.vsphere_datacenter.node_dc.id}"
  name          = "${var.vsphere_template}"
}

resource "vsphere_virtual_machine" "nodes" {
  count = "${var.node_count}"
  name = "${var.node_prefix}${var.node_name}-${count.index}"
  datastore_id = "${data.vsphere_datastore.node_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.node_pool.id}"
  num_cpus = 2
  memory = 4096
  guest_id = "${var.node_guest_id}"

  disk {
    label            = "${var.node_prefix}${var.node_name}-${count.index}.vmdk"
    size             = "${var.node_disk_size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.node_template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.node_template.disks.0.thin_provisioned}"
  }

  network_interface {
    network_id = "${data.vsphere_network.node_network.id}"
  }



  clone {
    template_uuid = "${data.vsphere_virtual_machine.node_template.id}"
  }

  extra_config = {
    "guestinfo.cloud-init.config.data" = "${base64encode("${data.template_file.node.*.rendered[count.index]}")}"
    "guestinfo.cloud-init.data.encoding" = "base64"
  }
}


data "template_file" "node" {
  count = "${var.node_count}"
  template = "${file("${path.module}/files/cloud-config.tpl")}"

  vars = {
    hostname = "${var.node_prefix}${var.node_name}-${count.index}"
    ip_address = "${var.node_ips[count.index]}"
    gateway = "${var.node_gateway}"
    dns = "${jsonencode(split(",", var.node_dns))}"
    network_interface = "${var.node_network_interface}"
    initial_key = "${var.node_initial_key}"
    domain_name = "${var.node_domain_name}"
  }
}

resource "vsphere_compute_cluster_vm_anti_affinity_rule" "node_anti_affinity" {
  name                = "${var.node_prefix}node-anti-affinity"
  compute_cluster_id  = "${data.vsphere_compute_cluster.node_cluster.id}"
  virtual_machine_ids = "${vsphere_virtual_machine.nodes.*.id}"
}