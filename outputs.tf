output "vcn_id" {
  description = "OCID of the VCN"
  value       = oci_core_vcn.terraform_vcn.id
}

output "subnet_id" {
  description = "OCID of the public subnet"
  value       = oci_core_subnet.terraform_subnet.id
}

output "instance_public_ip" {
  description = "Public IP of the compute instance"
  value       = oci_core_instance.terraform_instance.public_ip
}

output "instance_id" {
  description = "OCID of the compute instance"
  value       = oci_core_instance.terraform_instance.id
}