region = "eu-west-2"

project_name = "mini-project"

vpc_cidr_block = "10.0.0.0/16"

public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]

keypair_name = "londonuk-key-pair.pem.pem"

instance_type = "t2.micro"

domain_name = "DEAMZ.SPACE"

output "vpc_id" {
    value = aws_vpc.assignment_vpc.id
}

output "elb_load_balancer_dns_name" {
    value = aws_lb.assignment-load-balancer.dns_name
}
