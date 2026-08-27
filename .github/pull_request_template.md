## TechXchange 2026 Lab — Student Submission Checklist

**Student branch name:** `student-<your-initials>`

Please confirm the following before submitting:

- [ ] I have created my own branch off `main` named `student-<your-initials>`
- [ ] I have copied `terraform.tfvars.template` to `terraform.tfvars` and filled in all values
- [ ] `terraform.tfvars` is **not** included in this PR (it is `.gitignore`'d)
- [ ] `terraform init` completed successfully
- [ ] `terraform plan` completed with no errors
- [ ] `terraform apply` completed successfully and all resources are running
- [ ] I can SSH into my workload VSI from the bastion host
- [ ] I have run `terraform destroy` at the end of the lab to clean up all resources

**Workload VSI Floating IP:** <!-- paste here -->
