# ==========================================
# outputs.tf
# ==========================================

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "alb_security_group_id" {
  description = "ID of ALB security group"
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "ID of EC2 security group"
  value       = aws_security_group.ec2.id
}

output "rds_security_group_id" {
  description = "ID of RDS security group"
  value       = aws_security_group.rds.id
}

output "web_1_public_ip" {
  description = "Public IP of web server 1"
  value       = aws_instance.web_1.public_ip
}

output "web_2_public_ip" {
  description = "Public IP of web server 2"
  value       = aws_instance.web_2.public_ip
}

output "web_1_private_ip" {
  description = "Private IP of web server 1"
  value       = aws_instance.web_1.private_ip
}

output "web_2_private_ip" {
  description = "Private IP of web server 2"
  value       = aws_instance.web_2.private_ip
}
output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.main.arn
}
output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.main.endpoint
}

output "rds_port" {
  description = "RDS database port"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.main.db_name
}