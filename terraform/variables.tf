variable "vsphere_user" {
    description = "User account to login to vSphere with."
}
variable "vsphere_password" {
    description = "Password to login to vSphere with."
}
variable "vsphere_server" {
    description = "vCenter server to login to."
}

variable "ssh_public_key" {
    description = "Public key for the SSH key used to access new nodes."
}

variable "splunk" {
    description = "Settings for Splunk nodes."
    type        = "map"
}