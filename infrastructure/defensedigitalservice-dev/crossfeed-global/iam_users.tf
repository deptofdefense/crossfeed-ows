
resource "aws_iam_user" "crossfeed-deploy" {
  name = "crossfeed-deploy"

  tags = local.project_tags
}
