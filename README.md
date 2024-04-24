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
01-Nginx-App1-Deployment-and-NodePortService.yaml
	
Welcome to StackSimplify
	
Feb 26, 2023
02-Nginx-App2-Deployment-and-NodePortService.yaml
	
Welcome to StackSimplify
	
Feb 26, 2023
03-Nginx-App3-Deployment-and-NodePortService.yaml
	
Welcome to StackSimplify
	
Feb 26, 2023
04-Ingress-SSL.yaml
	
Welcome to StackSimplify
	
Feb 26, 2023
05-Managed-Certificate.yaml
	
Welcome to StackSimplify
	
Feb 26, 2023
06-frontendconfig.yaml