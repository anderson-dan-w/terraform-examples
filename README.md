# Learning Terraform

Needed to `brew install terraform` and `terraform init` to connect `aws`

`tf plan` and `tf apply`

## BUG:
Already found a bug: cannot change `security group` because terraform doesn't understand how to remove it from the `ec2instance` before trying to destroy, so it fails (or rather waits for destruction and eventually times out).
