# infra-training-ref-infra
Reference implementation for Infra Training

## Architecture
![](./arch.excalidraw.png)


### Pre-Start
1. Ensure your aws credentials and token are set in your local environment.
Ref: https://blog.thoughtworks.net/freddy-escobar/how-to-access-aws-account-with-aws-sso-okta
2. Export a unique team_name env var, this team_name is used to isolate your terraform from others.
```bash
export TF_VAR_team_name=lion
```
## Week 2 

### Design 
The above architecture is structured into 3 separate stacks or root-modules.  
- **networking** - This stack is responsible for creating the VPC, Subnets and the org wide networking.
  - This stack does not depend on any stack
  - This stack provide subnet, subnet_group and vpc to subsequent EKS and Application stacks.
- **eks** - This stack is responsible for creating and managing the EKS cluster, required security groups, required
IAM roles for ops and administration and the K8s Namespace in which we expect to deploy application.
  - This stack depends on the networking stack for required subnets, vpc etc. 
  - This stack provides the eks cluster, security group, and k8s namespace for any consu
consuming application stack. 
- **app-a** - This stack is responsible for creating application specific resources like the RDS for app-a and
the RDS endpoint and credential details that is stores as a K8s Secret in the K8s Namespace created by
the eks stack.
  - This stack depends on the networking stack for subnet details
  - This stack depends on the eks stack for the cluster, security groups for connectivity and 
k8s namespace for storing rds credentials as a k8s secret. 

### Init, plan and apply from local
```bash
cd week2/stacks/<stack-name>
terraform init -backend-config="key=${TF_VAR_team_name}/dev/<stack-name>"
terraform apply --var-file=../../environments/<stack-name>/dev.tfvars
```

Example for Networking stack
```bash
cd week2/stacks/networking
terraform init -backend-config="key=${TF_VAR_team_name}/dev/networking"
terraform apply --var-file=../../environments/networking/dev.tfvars
```

### Circle CI integration and Deploying via pipeline
There is Circle CI integration via config at [.circleci/config.yml](circleci/config.yml) and [.circleci/continue_config.yml](.circleci/continue_config.yml). 
1. Fork this repository
   1. Ensure your forked repository is in the https://github.com/Thoughtworks-SEA-Capability Org. If
   you are not a member of this Org, please ask Ankit to add you. 
   2. Recommended to pre-fix your repo name with your team name eg. 'lion-infra-training-ref-infra'
2. **Incase needed** `git reset` to the tag/commit shared in the Trello Card, to ensure you are at the correct working version of the code.
   This should give you a fresh working environment for week 2, even in the case I'm pushing to the upstream asynchronously. 
```bash
git reset --hard <commit>
git push -f
```
3. Ensure you replace the `team` parameter in [.circleci/continue_config](.circleci/continue_config.yml) to your unique team name
```yaml
version: 2.1

parameters:
  team:
    type: string
    default: '<team-name>'
``` 
4. Create a free account in 'https://app.circleci.com/', with your Github credentials.
   1. At this point you should be able to see the **Thoughtworks-SEA-Capability** Org and it's projects. 
   2. You should be able to see your repo as a Project.
5. Click on "Setup Project" for your repo. (Ref image attached in Trello Card)
   1. in "Select your config.yml file" select the **Fastest** option
   2. select the 'main' branch.
6. Enable option - Project Settings > Advanced > Enable dynamic config using setup workflows.
   (Ref image attached in Trello Card) 
7. Try pushing some small change, adding an output, to networking or eks stacks to validate pipelines work.


--- 
# Week 1

### Init, plan and apply
```bash
cd stacks/terralith
terraform init -backend-config="key=${TF_VAR_team_name}/dev/terralith"
terraform apply --var-file=dev.tfvars
```

### Test
1. Ensure you have created and set the K8s context to the EKS Cluster created as part of this project.
These values should be available from the output of the terralith terraform project.
```bash
aws eks update-kubeconfig --region ap-southeast-1 --name <cluster_name> --role-arn <cluster_admin_role_arn>
# aws eks update-kubeconfig --region ap-southeast-1 --name ankit-dev-terralith --role-arn arn:aws:iam::911960542707:role/ankit-dev-terralith-eks-admin
```
2. CD into the test directory and run the tests
```bash
cd tests
go test 
```
