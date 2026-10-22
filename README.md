# TechXchange 2026 — Hands-on Lab
## Declarative IBM Cloud Operations: Deploying a Secure VPC and VSI via Terraform with IBM Concert Observability

---

## Overview

In this lab you will use HashiCorp Terraform to provision a production-ready environment on IBM Cloud, consisting of:

- A **Virtual Private Cloud (VPC)** with a subnet
- A **Security Group** allowing SSH access
- A **RHEL 9 Virtual Server Instance (VSI)** (`bx2-2x8` — 2 vCPU / 8 GB RAM)
- A **Floating IP** attached to the VSI for internet connectivity

You will then integrate your environment with **IBM Concert** for AI-powered observability and OS patching.

> **Note:** The Bastion Host you are connected to is pre-provisioned. You do not need to deploy it.

---

## Prerequisites

Before starting, make sure you have the following ready:

| Item | Where to find it |
|---|---|
| IBM Cloud API Key | IBM Cloud Console > Manage > Access (IAM) > API keys > Create |
| Resource Group name | `txc-lab-2026` (pre-provisioned) |
| SSH Key Name | `txc-lab-2026-shared-key` (pre-provisioned) |

---

## Step 1 — Create your branch

On GitHub, navigate to this repository and create a new branch using your initials or a unique identifier (e.g. `student-ao`).

---

## Step 2 — Clone your branch to the Bastion Host

SSH into your Bastion Host, then clone your branch:

```bash
git clone -b <your-branch-name> https://github.com/IBM-TechExchange-2026/terraform-lab-template.git
cd terraform-lab-template
```

---

## Step 3 — Configure your variables

Copy the template variables file and fill in your values:

```bash
cp terraform.tfvars.template terraform.tfvars
```

Open `terraform.tfvars` in a text editor and replace every `TODO` value:

```bash
vi terraform.tfvars
```

| Variable | Description |
|---|---|
| `ibmcloud_api_key` | Your IBM Cloud API key |
| `resource_group_name` | Pre-filled: `txc-lab-2026` (do not change) |
| `prefix` | A short unique prefix, e.g. `txc-lab-ao` |
| `ssh_key_name` | Pre-filled: `txc-lab-2026-shared-key` (do not change) |
| `region` | IBM Cloud region — `us-east` (default) |
| `zone` | Availability zone — `us-east-1` (default) |

> **Important:** `terraform.tfvars` is listed in `.gitignore` and will **not** be committed to GitHub. Never share your API key.

---

## Step 4 — Initialise Terraform

```bash
terraform init
```

This downloads the IBM Cloud Terraform provider.

---

## Step 5 — Plan your deployment

```bash
terraform plan
```

Review the output and confirm the resources match what is expected (1 VPC, 1 subnet, 1 security group with 2 rules, 1 VSI, 1 floating IP — 7 resources total).

---

## Step 6 — Apply your deployment

```bash
terraform apply
```

Type `yes` when prompted. Deployment takes approximately 2–3 minutes.

Once complete, Terraform will output:

| Output | Description |
|---|---|
| `workload_vsi_floating_ip` | Public IP of your VSI |
| `workload_vsi_id` | Resource ID of your VSI |
| `vpc_id` | Resource ID of your VPC |
| `ssh_command` | Ready-to-run SSH command to connect to your VSI |

---

## Step 7 — Connect to your VSI

Use the SSH command from the Terraform output to connect to your workload VSI from the Bastion Host:

```bash
ssh -i ~/.ssh/txc-lab-key vpcuser@<workload_vsi_floating_ip>
```

---

## Step 8 — IBM Concert Integration

Once your VSI is running, download the workflow `.zip` packages from the [`workflows/`](workflows/) directory in this repository to your laptop, then follow the IBM Concert lab guide to import, scan, and patch your instance.

---

## Cleanup

When instructed, destroy all provisioned infrastructure:

```bash
terraform destroy
```

Type `yes` when prompted. This will remove all resources created during the lab.
