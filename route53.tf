variable "domain_name" {
    default     = "DEAMZ.SPACE"
    type        = string
    description = "Domain name"
}

resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "site_domain" {
    zone_id = aws_route53_zone.hosted_zone.zone_id
    name    = "terraform-test.${var.domain_name}"
    type    = "A"

    alias {
      name                     = aws_lb.assignment-load-balancer.dns_name
      zone_id                  = aws_lb.assignment-load-balancer.zone_id
      evaluate_target_health  = true
    }
}
