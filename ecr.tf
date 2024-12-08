# resource "aws_ecr_repository" "summafy" {
#     name = "summafy-repo"
#     image_tag_mutability = "MUTABLE"
#     force_delete = true
# }

data "aws_ecr_repository" "summafy"{
    name = "summafy-repo"
}

output "summary-container-repo" {
	value = data.aws_ecr_repository.summafy.repository_url
}
 