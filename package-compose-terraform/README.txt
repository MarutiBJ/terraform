## Command to run this script 

cd package-compose-terraform

terraform get

terraform apply -var-file=/home/compose/package-compose-terraform/providers/aws/dev/dev-aws.tfvars -var 'tf_home=/home/compose/package-compose-terraform' -state=state/aws/dev-aws/aws.tfstate


terraform plan -var-file=providers/aws/dev/dev-aws.tfvars -var 'tf_home=/home/compose/package-compose-terraform' -state=state/aws/dev-aws/aws.tfstate


