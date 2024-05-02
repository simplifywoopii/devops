#!/bin/sh

terraform init -backend-config ${TERRAFORM_BACKEND_CONF}
terraform workspace select ${TERRAFORM_WORKSPACE}