# Opella Azure Terraform – Multi-Env VNet + VM + Storage

This repo provisions Azure infrastructure with Terraform using a **reusable VNet module**. It demonstrates a **dev** and **prod** environment, a small **Ubuntu VM**, and an **Azure Storage Account** for blobs. It follows best practices: modules, tagging, linting, security scanning, automated docs, and a GitHub Actions pipeline with **OIDC** (no secrets) for plan/apply.

## What you get
- Reusable `modules/vnet` to create a VNet, subnets, optional NSG + rules, and outputs (IDs, names, CIDRs).
- Environments under `envs/dev` and `envs/prod` consuming the module + adding VM and Storage.
- Consistent naming & tagging via locals and input variables.
- GitHub Actions pipeline to **plan on PR** and **apply on main** per environment.
- Pre-commit hooks: `terraform fmt`, `tflint`, `tfsec`, `terraform-docs`.

## Why subscriptions vs resource groups?
- **Subscriptions** are ideal for strong isolation (quotas, RBAC, cost boundaries). Use per env (dev/prod) in larger orgs.
- **Resource Groups** are fine for small orgs or free-tier constraints. This example uses **RGs per env** (simpler) but supports separate subscriptions by setting `ARM_SUBSCRIPTION_ID` in the workflow.

## Requirements
- Terraform >= 1.6
- AzureRM provider >= 3.100
- If running locally: `az login` and set subscription.

## Quickstart (Dev)
```bash
cd envs/dev
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

## GitHub OIDC Setup (no long-lived secrets)
1. In Azure AD, create a **Federated Credential** on an App Registration to trust your GitHub repo:
   - Issuer: `https://token.actions.githubusercontent.com`
   - Subject: `repo:<org>/<repo>:ref:refs/heads/main` (and/or `pull_request` for PRs)
2. Grant the App `Contributor` on the target subscription or resource group.
3. Put the following in repo **Actions secrets** (actually none needed with OIDC). Optionally store `ARM_SUBSCRIPTION_ID` and `ARM_TENANT_ID` as variables.

## Environments
- `envs/dev`: East US, tiny VM size.
- `envs/prod`: West Europe, larger VM size (example) — safe defaults, no public SSH by default.

## Generate Module Docs
```bash
./scripts/generate-docs.sh
```
This uses `terraform-docs` to update `modules/vnet/README.md` and root README.

## Testing
- Static: `tflint`, `tfsec`, `terraform validate`
- (Bonus) Add Terratest in Go later.

## Cleanup
```bash
cd envs/dev && terraform destroy -auto-approve
cd ../prod && terraform.destroy -auto-approve
```
