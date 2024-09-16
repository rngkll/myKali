# Linode Provider definition
terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.27.0"
    }
  }
}

provider "linode" {
  token = var.token
}

# My Kali machine for pen testing
resource "linode_instance" "myKali" {
  image           = "linode/kali"
  label           = "myKali010"
  tags            = ["securityLAB"]
  region          = var.region
  type            = "g6-standard-1"
  swap_size       = 1024
  authorized_keys = [var.authorized_keys]
  root_pass       = var.root_pass

  # Setup firewall
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y ufw",
      "echo 'y' | sudo ufw enable",
      "echo 'y' | sudo ufw allow ssh"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
      host        = self.ip_address
    }
  }
  # Setup remote VNC server
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt -y install xfce4-goodies xfce4",
      "sudo apt install -y tightvncserver"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
      host        = self.ip_address
    }
  }
}

output "linode_ip" {
  value = linode_instance.myKali.ip_address
}

output "linode_label" {
  value = linode_instance.myKali.label
}

output "linode_id" {
  value = linode_instance.myKali.id
}
