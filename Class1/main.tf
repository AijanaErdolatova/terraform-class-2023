resource "aws_iam_user" "lb" {
  name = "kaizen"
  }

resource "aws_iam_user" "lb1" {
    name = each.key
    for_each = toset([
        "user",
        "user1",
        "user2"
    ])      
}

resource "aws_iam_group" "devops" {
  name = "devops"
  }


resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.lb.name,
  ]

  group = aws_iam_group.devops.name
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "example" {
  bucket_prefix = "aijana-bucket"
}

output bucket_info{
  value = aws_s3_bucket.example.arn
}

output group_info{
  value = aws_iam_group.devops.arn
}

