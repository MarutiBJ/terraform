## Command to run this script 

cd package-compose-terraform

terraform plan -var-file=providers/aws/dev/dev-aws.tfvars -var 'tf_home=/home/compose/package-compose-terraform' -state=state/aws/dev-aws/aws.tfstate


