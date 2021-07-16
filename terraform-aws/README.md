# terraform commands

Scan provider and download the provider code in .terraform: tf init
Format: tf fmt
Planning: tf plan
Deploy the infra: tf apply
alias tfa='tf apply'
tf destroy

# utilities

Set an alias in windows: doskey tf=terraform
Set an alias in unix: alias tf=terraform
Set an alias in unix:alias tfd='terraform destroy -auto-approve'
Create a new profile: aws configure --profile terraform
Switch profile: setx AWS_PROFILE terraform
Unix: ls -l = ll

# 1-single_instance

ssh in the instance:

- curl http://169.254.169.254/latest/meta-data/public-ipv4
- sudo grep cloud-init /var/log/messages

# 2-asg

Networking: 1 VPC , 3 public subnets, 3 private subnets, 1 IGW, 1 NAG_GW
Routing: 1 RT for public, 1 RT for private
FW: 1 SG for public, 1 SG for private
Compute: 1 Launch Configuration, 1 Target Group, 1 ASG (min 2, max 10)
LB: 1 ALB
IAM: 1 IAM role for SSM, 1 instance profile

# 3-backend

Backend: 1 S3 bucket, 1 DynamoDB for locking

# 4-backend

cd workspace-1/

- tf init
- tf workspace new ws1
- tf init
- terraform workspace show
- tf apply

- tf workspace new ws2
- tf init
- tf apply

# 5- file layout isolation

stage
└ vpc
└ services
└ frontend-app
└ backend-app
└ main.tf
└ outputs.tf
└ variables.tf
└ data-storage
└ mysql
└ redis
prod
└ vpc
└ services
└ frontend-app
└ backend-app
└ data-storage
└ mysql
└ redis
mgmt
└ vpc
└ services
└ bastion-host
└ jenkins
global
└ iam
└ s3

# 6- script curl

$ while true

> do
> curl http://34.224.85.43/
> sleep 1
> done
