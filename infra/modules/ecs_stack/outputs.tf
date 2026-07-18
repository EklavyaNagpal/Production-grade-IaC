output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "frontend_service_name" {
  value = aws_ecs_service.frontend.name
}

output "backend_service_name" {
  value = aws_ecs_service.backend.name
}
