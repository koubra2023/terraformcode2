provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_lightsail_instance" "example" {
  name              = "my-lightsail-instance"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_2_0"
  #key_pair_name     = "your_ssh_key_name_here"  # Replace with your SSH key pair name
  user_data = <<-EOF
    sudo yum update -y 
    sudo yum install unzip wget httpd -y  ( apt install wget unzip -y )
    sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
    sudo unzip main.zip
    sudo rm -rf /var/www/html/*
    sudo cp -r static-resume-main/* /var/www/html/  
    sudo systemctl start httpd
    sudo systemctl enable httpd 
              EOF
}

output "public_ip" {
  value = aws_lightsail_instance.example.public_ip_address
}

