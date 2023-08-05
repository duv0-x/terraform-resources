output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID de la VPC creada"
}

output "subnet_ids" {
  value       = aws_subnet.subnets.*.id
  description = "Lista de IDs de las subredes creadas"
}
