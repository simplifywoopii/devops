`backend.sample.conf` -> `backend.conf`  
`terraform.sample.tfvars` -> `terraform.tfvars`로 이름을 변경

```bash
terraform init -backend-config backend.conf

# terraform workspacec setting

# create terraform workspace
terraform workspace new dev

# select terraform workspace
terraform workspace select dev
```
