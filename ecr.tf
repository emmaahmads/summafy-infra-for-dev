resource "aws_ecr_repository" "summafy" {
     name = "summafy-repo"
     image_tag_mutability = "MUTABLE"
     force_delete = false
}

/*data "aws_ecr_repository" "summafy"{
    name = "summafy-repo"
}

output "summary-container-repo" {
	value = data.aws_ecr_repository.summafy.repository_url
}*/

output "summafy-container-repo" {
	value = aws_ecr_repository.summafy.repository_url
}
 
