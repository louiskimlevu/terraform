KEEP THIS REPO PRIVATE

# benefits of IAC

Infrastructure resources like GCP Folders/Projects, Kubernetes cluster, GCS buckets can be codified and deployed via Terraform. By using an IaC tool, we get multiple benefits:

- Versioning: We can use Git to keep the history of the changes of the infrastructure which makes it easier to rollback
- Idempotency: even if the same code is applied multiple times, the result remains the same
- Consistency: Using Terraform for provisioning GCP infrastructure provides a unified workflow to call Google APIs. It is the same way deployment flows over time and all teams are aware of best practices.
- Repeatability: With modules, we can standardize the code and avoid manual errors
- Predictable: With terraform plan command, we can also test the code and review the results before the code is applied. This provides an additional layer of security for your infrastructure provisioning
- Automation: We can setup CICD triggers/hooks deployment from Pull Requests to automate the deployment which not only save time but also eliminate manual errors

# Install TF WSL2

## option 1: Download , unzip, mv to usr/local/bin

`sudo apt-get update && sudo apt-get upgrade && sudo apt-get install unzip`

Go to https://www.terraform.io/downloads.html

`wget <terraform_url_for_linux> -O terraform.zip && unzip terraform.zip && sudo mv terraform /usr/local/bin && rm terraform.zip`
`terraform -v`

## option2: Package manager, add GPG key,

`sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl`
`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`
`sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`
`sudo apt-get update && sudo apt-get install terraform`

# logs

TF_LOG=TRACE

# Workflow

tf init > tf fmt -recursive > tf validate > > tf plan > tf apply > tf output > tf destroy -auto-approve >
terraform fmt -recursive

## terraform init

Will download providers plugin in .terraform in the same directory where the command is executed.
It can download multiple providers plugins if there are multiple providers block

# Provider

A plugin that enables Terraform to interface with the API layer of various cloud platforms and environments.

## Internal registry

You can reference providers from an internal registry in your Terraform code.

## Public provider registry

By default, Terraform looks for providers in the Terraform providers public registry so you only have to reference the provider in your code via provider block

## local provider

TYou can have a local provider and reference that provider in your Terraform code in your configuration.

# provider and version

If version is not mentionned, latest is used

```terraform
provider "aws"{
    version="3.50.0"
    region="us-east-1"
}
```

## provider alias

Alias is used to create resources with different providers (ex: )
Another use case is service accounts impersonation for tf GCP best practices

```terraform
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
resource "aws_instance" "foo" {
  provider = aws.west
  # ...
}
```

## Auth for AWS

Best practice is to have 1 automation account hosting tf user, other accounts for resource provisioning,

- Create IAM user with programatic access only in automation account is granted STS-Write/AssumeRole customer-managed-policy for X-account ARN roles (has many as the number of resource/target accounts)
- Create these X-account roles are created in resource/target accounts with trusted identity beeing Automation account

- Option1 : AWS_PROFILE env var using AK/SAK
  `AWS_PROFILE=default && printenv | grep AWS_PROFILE && aws configure list-profiles`
  `aws configure --profile terraform `
  -> set ak,sak
  `AWS_PROFILE=terraform && printenv | grep AWS_PROFILE && aws configure list`
  For listing windows envs -> set, ex: `set | findstr "AWS_PROFILE"`

## Auth for GCP

Set envvars before running tf init/plan/apply
Best practice is to have 1 project for automation and other projects for resource provisioning:

- Project automation: create source-sa + key + download key in this directory + Enable IAM Service Account Credentials API
- Project resource: create impersonated-sa + grant source-sa Token Creator Role

- Option1 credentials field in provider block refers fo file(sa-key.json)
  path to sa key in provider block -> credentials = file("tf-source-service-account.json")
- Option2 env GOOGLE_CLOUD_KEYFILE_JSON
  ` export GOOGLE_CLOUD_KEYFILE_JSON=tf-source-service-account.json`
  ` export GOOGLE_APPLICATION_CREDENTIALS=tf-source-service-account.json`

# state

help tf keeps track/map resources defined as code and resources deployed
if no remote backend{} is configurd, the state file resides in the same directory inside .terraform
stored a json data in terraform.tfstate
stored as json data

# data

- Resource: Provisioning of resources/infra on our platform. Create, Update and delete!
- Variable: Provides predefined values as variables on our IAC. Used by resource for provisioning.
- Data Source: Fetch values from our infra/provider and and provides data for our resource to provision infra/resource.

```terraform
# resource "aws_instance" "web" {
# 	ami           = data.aws_ami.ubuntu.id
# 	instance_type = "t2.micro"
# }

data "aws_ami" "ubuntu" {
	most_recent = true
	owners      = ["self"]

	filter {
		name = "name"
		values = ["tuts-ubuntu"]
	}
}

data "aws_vpc" "foo" {
	default = true
}

data "aws_vpc" "main" {
	filter {
		name  = "tag:Name"
		values = ["PROD-VPC"]
	}
}

output "vpc" {
	value = data.aws_vpc.foo
}
```

# variables

Best practices is to:

- keep var definitions in separate file than other infra name ex: variables.tf
- Keep var values in separate file named terraform.tfvars, the content of this file can refer other terraform.tfvars ex: ../../terraform.tfvars

## basic types

- bool
- string
- number
- any : determined at runtime

```terraform
variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
  default="123456798"
}
var.org_id
```

## collection types

- list = a sequence of values identified by consecutive whole numbers starting with zero.
- map = schema = { foo = "bar", bar = "baz" }
- set = a collection of unique values that do not have any secondary identifiers or ordering.

## Structural types

- object = a collection of named attributes that each have their own type. schema:{ <KEY> = <TYPE>, <KEY> = <TYPE>, ... }
  ex: object({ name=string, age=number })
  ex:

```{
 name = "John"
 age  = 52
}
```

- tuple = a sequence of elements identified by consecutive whole numbers starting with zero, where each element has its own type. schema: [<TYPE>, <TYPE>, ...]
  ex: tuple([string, number, bool])

```terraform
variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}
```

```terraform
variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}
```

## locals

```terraform
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```

## var validation

terraform will not run plan/apply if validation criteria is not true which can save time

```terraform
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}
```

## var sensitive

Setting a variable as sensitive prevents Terraform from showing its value in the plan or apply output, when you use that variable elsewhere in your configuration.

Terraform will still record sensitive values in the state, and so anyone who can access the state data will have access to the sensitive values in cleartext

```terraform
variable "user_information" {
  type = object({
    name    = string
    address = string
  })
  sensitive = true
}

resource "some_resource" "a" {
  name    = var.user_information.name
  address = var.user_information.address
}
```

## Var options and precedence

- can be predefined in predefined in tf.vars
- can be included as part of -var flar option
- can be pull down from TF Cloud
  OS envs > terraform.tfvars
  ex:

```
variable "replicas" {
 type = number
 default = 5
}
```

`terraform apply -var replicas=1`
value of replicas will be 1 and not 5-

# output

Use cases:

- A child module can use outputs to expose a subset of its resource attributes to a parent module.
- A root module can use outputs to print certain values in the CLI output after running terraform apply.
- When using remote state, root module outputs can be accessed by other configurations via a terraform_remote_state data source.

```terraform
output "instance_ip_addr" {
  description="private IP of the instance"
 value = aws_instance.server.private_ip
}
```

# provisioners

used for config management like ansible.
execute scripts on a local or remote machine as part of resource creation or destruction
If the command within a provisioner returns a non-zero code, the resource is marked as tainted. A tainted resource will be planned for destruction and recreation upon the next terraform apply
Multiple provisioners can be defined a resource

## local-exec

The local-exec provisioner requires no other configuration, but most other provisioners must connect to the remote system using SSH or WinRM.
local-exec provisioner helps run a script on instance where we are running our terraform code, not on the resource we are creating. For example, if we want to write EC2 instance IP address to a file, then we can use below local-exec provisioner with our EC2 resource and save it locally in a file.

```terraform
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

## remote-exec (better to use user data/bootstrap scripts)

remote-exec provisioner helps invoke a script on the remote resource once it is created.
We can provide:

- a list of command strings which are executed in the order they are provided
- scripts with a local path which is copied remotely and then executed on the remote resource. file provisioner is used to copy files or directories to a remote resource. We can’t provide any arguments to script in remote-exec provisioner. We can achieve this by copying script from file provisioner and then execute a script using a list of commands.

AWS Example:

1. Update security group with port 22 and port 80 open from 0.0.0.0/0. Port 22 is used to SSH by terraform remote-exec provisioner to setup Nginx and Port 80 is used by us when making HTTP call from our browser.
2.

```terraform

resource "aws_key_pair" "webserver-key" {
  key_name   = "pub-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "webserver" {
  ami                         = data.aws_ssm_parameter.webserver-ami.value
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.webserver-key.pub-key
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
  tags = {
    Name = "webserver"
  }
}
```

## Destroy-time provisioner

Destroy provisioners are run before the resource is destroyed. If they fail, Terraform will error and rerun the provisioners again on the next terraform apply. Due to this behavior, care should be taken for destroy provisioners to be safe to run multiple times.

```terraform
resource "null_resource" "mk" {
  provisioner "local-exec" {
    command = "echo '0' > status.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "echo '1' > status.txt"
  }
}
}
```

# state

## terraform.tfstate

can be used to retrieve outputs of a state
Dont interact with tfstate file directly, just use plan/apply/destroy
Prior to plan/apply, tf refresh the state
state contains dependencies to build the

terraform destroy, create a terraform.tfstate.backup in case the state file is lost or corrupted to simplify recovery

## terraform state sub commends

`terraform state list`
`terraform state rm`
`terraform state show`

```
louiskim@DESKTOP-NPEV1IB:/mnt/c/Users/lk_le/Coding/terraform/0-API-vendors-auth-best-practices/aws$ terraform state list
aws_s3_bucket.b
louiskim@DESKTOP-NPEV1IB:/mnt/c/Users/lk_le/Coding/terraform/0-API-vendors-auth-best-practices/aws$ terraform state show aws_s3_bucket.b
# aws_s3_bucket.b:
resource "aws_s3_bucket" "b" {
    acl                         = "private"
    arn                         = "arn:aws:s3:::my-lklv-tf-test-bucket"
    bucket                      = "my-lklv-tf-test-bucket"
    bucket_domain_name          = "my-lklv-tf-test-bucket.s3.amazonaws.com"
    bucket_regional_domain_name = "my-lklv-tf-test-bucket.s3.amazonaws.com"
    force_destroy               = false
    hosted_zone_id              = "Z3AQBSTGFYJSTF"
    id                          = "my-lklv-tf-test-bucket"
    region                      = "us-east-1"
    request_payer               = "BucketOwner"
    tags                        = {
        "Environment" = "Dev"
        "Name"        = "My bucket"
    }
    tags_all                    = {
        "Environment" = "Dev"
        "Name"        = "My bucket"
    }

    versioning {
        enabled    = false
        mfa_delete = false
    }
}
```

## data source terraform_remote_state

Pull outputs data from an external state file (remote or local)

```terraform
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "hashicorp"
    workspaces = {
      name = "vpc-prod"
    }
  }
}
resource "aws_instance" "foo" {
  # ...
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}
```

#### Remote Backend + statelocking

- step 1:
  main.tf (provider only)

```terraform

provider "aws" {
  region = "us-east-1"
}
```

backend.tf (s3 + dynamo)

```terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-backend-lklv"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
```

- step 2: terraform init > plan > apply
- step 3: Update main.tf to add terraform {backend} block
  main.tf

```terraform
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    #AWS CLI profile
    profile="terraform"

    bucket = "tf-backend-lklv"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
```

### local remote + terraform_remote_state example

```terraform
data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "..."
  }
}
resource "aws_instance" "foo" {
  # ...
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}
```

# modules

reusable packages
every tf configuration has at least one module -> root which consists of tf files inside the directory
Access modules

- public/private registry
- local registry

```terraform
module "servers" {
source = "../modules/vpc"
#source = "terraform-aws-modules/vpc/aws"
version="0.0.5"
region=var.region
}
```

# allowed parameters in modules

- count
- for_each
- providers
- depends_on

# access modules output

module.name-of-module.name-of-output

```terraform
resource "aws_instance" vm{
  ...
  subnet_id=module.my-vpc-module.subnet-id
}
```

## Built in functions

- join()

```terraform
var "project-name"{
  type=string
  default="prod"
}
resource "aws_vpc"{
  cidr_block="10.0.0.0/16"
  tags={
    Name=join("-",["terraform,var.project-name])
  }
}
```

- file()

```terraform
credentials = file("tf-source-service-account.json")
```

- timestamp
- max
- flatten
- contains(["acloud","guru",1,2,3],"guru)

# terraform console

# Dynamic blocks

# Operators

!, - (multiplication by -1)
\*, /, %
+, - (subtraction)

> , >=, <, <=
> ==, !=
> &&
> ||

# Conditions

condition ? true_val : false_val
var.a != "" ? var.a : "default-a"

# for expression

The examples use [ and ], which produces a tuple. If you use { and } instead, the result is an object and you must provide two result expressions that are separated by the => symbol:

[for s in var.list : upper(s)]
[for k, v in var.map : length(k) + length(v)]
{for s in var.list : s => upper(s)}
