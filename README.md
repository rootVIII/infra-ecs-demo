
- Use `backend_setup/` to create AWS S3 buckets for TF State storage
  (development and/or production)

- init and apply from within `backend_setup/`

- Update the bucket name in the appropriate backend.hcl file after
applying the backend setup: `environments/<env>/backend.hcl`

- Update the ECS Repository URL in `environments/<env>/terraform.tfvars`
after applying the backend setup

- Ensure a docker file/image is added to the repository:
```
# Run from project root where the example Dockerfile is located
ecr_url="<aws_account_id>.dkr.ecr.<region>.amazonaws.com/<repository-name>"
docker build -t placeholder-webapp .
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "${ecr_url}"
docker tag placeholder-webapp "${ecr_url}"
docker push "${ecr_url}"
```

- terraform init/apply from `environments/dev` or `environments/prd`:

```# Navigate to environments/<env>
terraform init -backend-config=backend.hcl
terrafrom validate
terraform plan
terrafrom apply```

# Vist the ECS Container task public IP address to view the example webapp

# Example accessing shell session:

aws ecs update-service --cluster <cluster name> --service <service name> --region <region> --enable-execute-command
aws ecs execute-command --region <region>  --cluster <cluster name>  --task "<task arn>" --container <container name> --command "/bin/sh" --interactive
```
