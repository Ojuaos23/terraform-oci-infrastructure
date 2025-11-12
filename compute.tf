# Get available ADs
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}
# Get the latest Oracle Linux image
data "oci_core_images" "oracle_linux" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = "VM.Standard.E2.1.Micro"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

# Compute Instance
resource "oci_core_instance" "terraform_instance" {
 availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "terraform-web-server"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.terraform_subnet.id
    display_name     = "terraform-vnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file("${path.module}/ssh-key.pub")
  }
}