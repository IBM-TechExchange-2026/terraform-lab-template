##############################################################################
# VPC
##############################################################################
resource "ibm_is_vpc" "lab_vpc" {
  name                      = "${var.prefix}-vpc"
  resource_group            = data.ibm_resource_group.lab_rg.id
  address_prefix_management = "auto"
}

##############################################################################
# Subnet
##############################################################################
resource "ibm_is_subnet" "lab_subnet" {
  name                     = "${var.prefix}-subnet"
  vpc                      = ibm_is_vpc.lab_vpc.id
  zone                     = var.zone
  total_ipv4_address_count = 256
  resource_group           = data.ibm_resource_group.lab_rg.id
}

##############################################################################
# Security Group
##############################################################################
resource "ibm_is_security_group" "lab_sg" {
  name           = "${var.prefix}-sg"
  vpc            = ibm_is_vpc.lab_vpc.id
  resource_group = data.ibm_resource_group.lab_rg.id
}

# Allow inbound SSH from anywhere (bastion and IBM Concert patching)
resource "ibm_is_security_group_rule" "allow_ssh_inbound" {
  group     = ibm_is_security_group.lab_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  protocol  = "tcp"
  port_min  = 22
  port_max  = 22
}

# Allow all outbound traffic
resource "ibm_is_security_group_rule" "allow_all_outbound" {
  group     = ibm_is_security_group.lab_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  protocol  = "any"
}

##############################################################################
# SSH Key
##############################################################################
resource "ibm_is_ssh_key" "lab_ssh_key" {
  name           = "${var.prefix}-ssh-key"
  public_key     = var.ssh_public_key
  resource_group = data.ibm_resource_group.lab_rg.id
}

##############################################################################
# Workload VSI
##############################################################################
resource "ibm_is_instance" "workload_vsi" {
  name           = "${var.prefix}-workload-vsi"
  vpc            = ibm_is_vpc.lab_vpc.id
  zone           = var.zone
  profile        = "bx2-2x8"
  image          = data.ibm_is_image.rhel9.id
  resource_group = data.ibm_resource_group.lab_rg.id

  primary_network_interface {
    subnet          = ibm_is_subnet.lab_subnet.id
    security_groups = [ibm_is_security_group.lab_sg.id]
  }

  keys = [ibm_is_ssh_key.lab_ssh_key.id]
}

##############################################################################
# Floating IP — gives the workload VSI internet connectivity and allows
# the bastion and IBM Concert to reach it over the public internet
##############################################################################
resource "ibm_is_floating_ip" "workload_fip" {
  name           = "${var.prefix}-workload-fip"
  target         = ibm_is_instance.workload_vsi.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.lab_rg.id
}

##############################################################################
# Data Sources
##############################################################################
data "ibm_resource_group" "lab_rg" {
  name = var.resource_group_name
}

data "ibm_is_image" "rhel9" {
  name = "ibm-redhat-9-6-minimal-amd64-12"
}
