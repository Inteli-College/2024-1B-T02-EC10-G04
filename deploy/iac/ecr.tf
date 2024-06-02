resource "aws_ecr_repository" "control-center_ecr" {
  name                 = "confluentinc-cp-enterprise-control-center"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  
  tags = {
    name = "backend"
    menageBy = "Terraform"
  }
}

