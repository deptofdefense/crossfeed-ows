
resource "aws_iam_group" "crossfeed-deploy" {
  name = "crossfeed-deploy"
}

resource "aws_iam_group_membership" "crossfeed-deploy" {
  name = "crossfeed-deploy"

  users = [
    aws_iam_user.crossfeed-deploy.name,
  ]

  group = aws_iam_group.crossfeed-deploy.name
}
