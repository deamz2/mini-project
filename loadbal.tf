resource "aws_lb" "assignment-load-balancer" {
  name = "assignment-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.assignment-load_balancer_sg.id]
  subnets = [aws_subnet.assignment-public-subnet1.id, aws_subnet.ass-public-subnet2.id]
  enable_deletion_protection = false
  depends_on = [ aws_instance.assignment-1, aws_instance.ass-2, aws_instance.ass-3 ]
}

resource "aws_lb_target_group" "assignment-target-group" {
  name = "assignment-target-group"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.assignment_vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}


resource "aws_lb_listener" "assignment-listener" {
  load_balancer_arn = aws_lb.assignment-load-balancer.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.assignment-target-group.arn
  }
}

resource "aws_lb_listener_rule" "assignment-listener-rule" {
    listener_arn = aws_lb_listener.assignment-listener.arn
    priority     = 1

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.assignment-target-group.arn
    }

    condition {
      path_pattern {
        values = ["/"]
      }
    }
}

resource "aws_lb_target_group_attachment" "assignment-target-group-attachement1" {
  target_group_arn  = aws_lb_target_group.assignment-target-group.arn
  target_id         = aws_instance.assignment-1.id
  port              = 80
}

resource "aws_lb_target_group_attachment" "assignment-target-group-attachment2" {
  target_group_arn = aws_lb_target_group.assignment-target-group.arn
  target_id        = aws_instance.assignment-2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "assignment-target-group-attachment3" {
  target_group_arn = aws_lb_target_group.assignment-target-group.arn
  target_id        = aws_instance.assignment-3.id
  port = 80
}