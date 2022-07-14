# [GITHUB URL ](https://github.com/humbirs/demoassesment.git )
# TASK 1:

# Pre-Req & Assumption
- linux environment where docker is pre-installed, enabled and  running
- git should be installed and user should checkout the git repo from github
- TAG scheme is using `git reflog` command to fetch the revision number as assigning it to tag variable
- if git is not installed and someone has copied the git code then tag number will be assigned from $RANDAM variable in linux env.
- User should run local docker registry as this code is not handling the docker registry authentication
- This code has below files
-- task1/build.sh
-- task1/displayImageTag.sh
-- task1/nginxApp/Dockerfile
-- task1/nginxApp/src/index.html

## Steps
- Do a git clone from github url 
- navigate to task1
- make sure you have setup local registry
- make sure local registry is added in /etc/docker/daemon.json for insecure_registries 
- execute `./build.sh nginxApp 10.101.210.100:5000 demowebapp` where 10.101.210.100:500 is local registry IP , change it as per your local registry 
- it will build and push an image to local registry
- execure `./displayImageTag.sh '10.101.210.100:5000' demowebapp`  where 10.101.210.100:500 is local registry IP , change it as per your local registry, this will only display the last tag that had been pushed to repo.
- make any changes to code and commit it, then execute build.sh to create and push new image.

# Terraform for AWS infa setup and docker image deployment
- Below dir is holding terraform code for creating AWS ecs cluster and it also has a variable for docker image url that need to be deployed along side the build
- task1/aws-ecs-cluster
### Commands to run
-  take a clone from git repo
- change dir to task1/aws-ecs-cluster
- run `terraform init` to initialize the provider
- Update the variable in  task1/aws-ecs-cluster/terraform.tfvars , particularly `aws_access_key` and `aws_secret_key` with your access details
- run `terraform plan`
- run `terraform apply -auto-approve`
--  Doing above steps will setup an environment in AWS with supporting infra for AWS ECS cluster and also it will run an image as defined in variable `image_name_url = "docker.io/library/nginx:latest"`
-- This image can be from development registry as well considering that is accessible from this infra or development team can push image to ECR and make sure image url is pointing to that.




# TASK 2:

## DevOps Work : Automation of infrastructure build on on-prem DC

- Added three images i.e. showing the high level design. 
-- task2/ProblemView.png
-- task2/DeploymentLayout.png
-- task2/ansibledesign.drawio.svg

### Overall system thinking
- As a problem statement: we have several customer which get their h/w refreshed and in that process a complete build of existing virtulized environment has to be re-build on new h/w also if new component are being delivered then its supporting infra need to be build as new.
-- with TDA assigned to different project customer for same product each build seems different although the porduct is same
-- Also the issue raised from different customer are different as baseline infra build is not same at all places. 
- So we would need a unified solution which will bring all DC build in same baseline
-- also it should be flexible enough to handle specification change to the build

### Design decisions
- Key point to keep in mind is
-- create a unified framework that can be used for all project and customer
-- it should be flexible enough to accomodate dynamic requirement changes before application of the script
-- choosing a tool stack which can also be shared and integrated with Application deployment and configuration
-- framework should be secure and able to access or utilized encrypted password 
-- framework should be able to support and attach itself with wider infra provider present in 
-- it should support maven build via jenkins
-- all artifact should be stored on Nexus

### Build process & Interfaces
- Initially stated with small component like just integration of IDM with VM
- gradully incorporated all necessary component build like
-- creation of vm
-- regstring of vm with idm/satellite
-- modification in os storate/packages/network/hardening etc
-- furhter setting of other infra component i.e. nfs, idmqm, oracle etc
- all code must be stored in GIT/SVN and build via maven build 
-- framework had separate roles for different requirement which have thier own maven build and storing artifact on nexus
-- Parent pom will have dependency of all roles/plabook etc to have a one release that will be distributed to various users
-- all build process happend with the help of jenkins

### Testing
- Testing on smaller environment
- testing on on-prem simulated dc

### Identify brittle parts of the system – performance
- Having infra build via framework with more flexibility on non-cloud env have challenge to setting up networking on VM and assigning VM IP's etc
- Storage modification 


