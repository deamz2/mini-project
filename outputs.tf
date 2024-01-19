output "vpc_id" {
    value = aws_vpc.assignment_vpc.id
}

output "elb_load_balancer_dns_name" {
    value = aws_lb.assignment-load-balancer.dns_name
}