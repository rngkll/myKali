## Steps to kickstart
1. Copy terraform.tfvars_example to terraform.tfvars
1. Modify terraform.tfvars with proper values
1. `terraform init`
1. `terraform plan`
1. `terraform apply`
1. ssh and replace IP `ssh root@<ip> -L 5901:localhost:5901`
1. `terraform destroy`

## grafical interface using VNC
1. after ssh tunnel
1. Change to the non root user `su - <your user>`.
1. run `vncserver` and set password
1. From machine open vnc session `vnc://localhost:5901`
