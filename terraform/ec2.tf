# ==========================================
# ec2.tf
# EC2 instances, Key Pair, AMI data source
# ==========================================

# --- Get Latest Ubuntu 22.04 AMI ---
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --- Key Pair ---
resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)

  tags = {
    Name    = "${var.project_name}-key"
    Project = var.project_name
  }
}

# --- EC2 Instance 1 (Public Subnet 1) ---
resource "aws_instance" "web_1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.main.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Server 1 - ${var.project_name}</h1>" > /var/www/html/index.html
  EOF
  )

  tags = {
    Name    = "${var.project_name}-web-1"
    Project = var.project_name
  }
}

# --- EC2 Instance 2 (Public Subnet 2) ---
resource "aws_instance" "web_2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[1].id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.main.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Server 2 - ${var.project_name}</h1>" > /var/www/html/index.html
  EOF
  )

  tags = {
    Name    = "${var.project_name}-web-2"
    Project = var.project_name
  }
}