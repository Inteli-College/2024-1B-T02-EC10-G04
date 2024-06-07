resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "redis-subnet-group"
  subnet_ids = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id,
    aws_subnet.private_subnet_az1.id,
    aws_subnet.private_subnet_az2.id
  ]

  tags = {
    name     = "redis-subnet-group"
    menageBy = "Terraform"
  }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "redis-replication-group"
  description          = "redis with authentication"
  node_type            = "cache.t3.micro"
  num_cache_clusters   = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_sg.id]
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"

  transit_encryption_enabled = true
  auth_token                 = "myredispassword"
}
