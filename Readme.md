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

# Auth for AWS

Best practice is to have 1 automation account hosting tf user, other accounts for resource provisioning,

- Create IAM user with programatic access only in automation account is granted STS-Write/AssumeRole customer-managed-policy for X-account ARN roles (has many as the number of resource/target accounts)
- Create these X-account roles are created in resource/target accounts with trusted identity beeing Automation account

- Option1 : AWS_PROFILE env var using AK/SAK
  `AWS_PROFILE=default && printenv | grep AWS_PROFILE && aws configure list-profiles`
  `aws configure --profile terraform `
  -> set ak,sak
  `AWS_PROFILE=terraform && printenv | grep AWS_PROFILE && aws configure list`
  For listing windows envs -> set, ex: `set | findstr "AWS_PROFILE"`

# Auth for GCP

Set envvars before running tf init/plan/apply
Best practice is to have 1 project for automation and other projects for resource provisioning:

- Project automation: create source-sa + key + download key in this directory + Enable IAM Service Account Credentials API
- Project resource: create impersonated-sa + grant source-sa Token Creator Role

- Option1 credentials field in provider block refers fo file(sa-key.json)
  path to sa key in provider block -> credentials = file("tf-source-service-account.json")
- Option2 env GOOGLE_CLOUD_KEYFILE_JSON
  ` export GOOGLE_CLOUD_KEYFILE_JSON=tf-source-service-account.json`
  ` export GOOGLE_APPLICATION_CREDENTIALS=tf-source-service-account.json`

# logs

TF_LOG=TRACE

# terraform init

Will download providers plugin in .terraform in the same directory where the command is executed.
It can download multiple providers plugins if there are multiple providers block

# provider and version

If version is not mentionned, latest is used

```terraform
provider "aws"{
    version="3.50.0"
    region="us-east-1"
}
```

# provider alias

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

# state

help tf keeps track/map resources defined as code and resources deployed
if no remote backend{} is configurd, the state file resides in the same directory inside .terraform
stored a json data in terraform.state

# variables
Best practices is to:
- keep var definitions in separate file than other infra name ex: variables.tf
- Keep var values in separate file named terraform.tfvars, the content of this file can refer other terraform.tfvars ex: ../../terraform.tfvars

```terraform
variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
  default="123456798"
}
var.org_id
```
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
# var validation

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

# var sensitive
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