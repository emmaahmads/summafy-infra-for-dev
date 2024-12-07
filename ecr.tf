resource "aws_ecr_repository" "summafy" {
    name = "summafy-repo"
    image_tag_mutability = "MUTABLE"
    force_delete = true
}