Three-tier architecture in Azure using Terraform

Terrafform What is it?

Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp. It allows users to define and manage infrastructure configurations using a declarative configuration language. 
With Terraform, you can define the infrastructure components (such as virtual machines, networks, storage, etc.) in code, which can then be provisioned, updated, and managed automatically.

How to Install?

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Problem Statement
Consist of 2 app servers and 1 DB server and one load balancer
The app server will talk to DB.App will get requests from outside from port 80
App virtual machine -> allow inbound traffic from the internet.
The app can connect to the database and the database can connect to app but the database cannot connect to the web.
TFstate is saved in the Storage account. So all backup will happen there.

Diagram

![blank diagram](https://github.com/rajendran-k/CodingChallenge/assets/36255990/8d85f5eb-1a4d-49ff-a59d-e710188e89b9)


![impldiagram](https://github.com/rajendran-k/CodingChallenge/assets/36255990/9fedcc5c-7997-4275-9635-9e30ca148984)


All the stacks are placed in the modules folder and the variables are stored under terraform.tfvars

To run the code you need to append the variables in the terraform.tfvars

How to deploy:

Step 0 terraform init

used to initialize a working directory containing Terraform configuration files

Step 1 terraform plan

used to create an execution plan

Step 2 terraform validate

validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc

Step 3 terraform apply

used to apply the changes required to reach the desired state of the configuration
