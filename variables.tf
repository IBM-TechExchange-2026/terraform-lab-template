variable "ibmcloud_api_key" {
  description = "Your IBM Cloud API key. Retrieve from: IBM Cloud Console > Manage > Access (IAM) > API keys."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region to deploy resources into (e.g. us-south, eu-gb)."
  type        = string
  default     = "us-east"
}

variable "resource_group_name" {
  description = "Name of the IBM Cloud resource group to deploy resources into."
  type        = string
}

variable "prefix" {
  description = "Short prefix used to name all resources (e.g. your initials: 'txc-lab-<your-initials>')."
  type        = string
}

variable "ssh_public_key" {
  description = "Your SSH public key (contents of ~/.ssh/id_rsa.pub or equivalent). Used to access the workload VSI and by IBM Concert for OS patching."
  type        = string
}

variable "zone" {
  description = "Availability zone within the region (e.g. us-south-1)."
  type        = string
  default     = "us-east-1"
}
