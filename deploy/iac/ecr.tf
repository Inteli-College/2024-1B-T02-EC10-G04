resource "aws_ecr_repository" "backend_ecr" {
  name                 = "backend"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  
  tags = {
    name = "backend"
    menageBy = "Terraform"
  }
}

