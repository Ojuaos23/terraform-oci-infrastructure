# Virtual Cloud Network
resource "oci_core_vcn" "terraform_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "terraform-vcn"
  dns_label      = "terraformvcn"
}

# Internet Gateway
resource "oci_core_internet_gateway" "terraform_ig" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.terraform_vcn.id
  display_name   = "terraform-internet-gateway"
}

# Route Table
resource "oci_core_route_table" "terraform_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.terraform_vcn.id
  display_name   = "terraform-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.terraform_ig.id
  }
}

# Security List
resource "oci_core_security_list" "terraform_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.terraform_vcn.id
  display_name   = "terraform-security-list"

  # Allow SSH
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }

  # Allow HTTP
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }

  # Allow all outbound
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

# Public Subnet
resource "oci_core_subnet" "terraform_subnet" {
  cidr_block        = "10.0.1.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.terraform_vcn.id
  display_name      = "terraform-public-subnet"
  route_table_id    = oci_core_route_table.terraform_route_table.id
  security_list_ids = [oci_core_security_list.terraform_security_list.id]
  dns_label         = "public"
}