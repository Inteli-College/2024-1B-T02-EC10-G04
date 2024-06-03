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

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster-prod"
  engine               = "redis"
  engine_version       = "7"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7.x"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_sg.id]

  tags = {
    name     = "redis-cluster-prod"
    menageBy = "Terraform"
  }
}
