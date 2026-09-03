output "workload_vsi_floating_ip" {
  description = "Public floating IP address of the workload VSI. Use this to SSH in and to register with IBM Concert."
  value       = ibm_is_floating_ip.workload_fip.address
}

output "workload_vsi_id" {
  description = "Resource ID of the workload VSI."
  value       = ibm_is_instance.workload_vsi.id
}

output "vpc_id" {
  description = "Resource ID of the newly created VPC."
  value       = ibm_is_vpc.lab_vpc.id
}

output "ssh_command" {
  description = "SSH command to connect to your workload VSI from the bastion host."
  value       = "ssh -i <path-to-your-private-key> vpcuser@${ibm_is_floating_ip.workload_fip.address}"
}
