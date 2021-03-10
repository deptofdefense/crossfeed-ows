

data "aws_iam_policy_document" "crossfeed-deploy" {
  statement {
    sid     = "VisualEditor0"
    effect  = "Allow"
    actions = ["iam:CreateServiceLinkedRole"]
    resources = [
      "arn:aws:iam::*:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS",
    ]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values = [
        "rds.amazonaws.com"
      ]
    }
  }
  statement {
    sid    = "VisualEditor1"
    effect = "Allow"
    actions = [
      "acm:ListCertificates",
      "acm:ListTagsForCertificate",
      "acm:RequestCertificate",
      "apigateway:*",
      "cloudformation:CancelUpdateStack",
      "cloudformation:ContinueUpdateRollback",
      "cloudformation:CreateChangeSet",
      "cloudformation:CreateStack",
      "cloudformation:CreateUploadBucket",
      "cloudformation:DeleteStack",
      "cloudformation:Describe*",
      "cloudformation:EstimateTemplateCost",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:Get*",
      "cloudformation:List*",
      "cloudformation:UpdateStack",
      "cloudformation:UpdateTerminationProtection",
      "cloudformation:ValidateTemplate",
      "cloudfront:CreateFieldLevelEncryptionConfig",
      "cloudfront:CreateFieldLevelEncryptionProfile",
      "cloudfront:CreatePublicKey",
      "cloudfront:DeleteFieldLevelEncryptionConfig",
      "cloudfront:DeleteFieldLevelEncryptionProfile",
      "cloudfront:DeletePublicKey",
      "cloudfront:GetFieldLevelEncryption",
      "cloudfront:GetFieldLevelEncryptionConfig",
      "cloudfront:GetFieldLevelEncryptionProfile",
      "cloudfront:GetFieldLevelEncryptionProfileConfig",
      "cloudfront:GetPublicKey",
      "cloudfront:GetPublicKeyConfig",
      "cloudfront:ListCloudFrontOriginAccessIdentities",
      "cloudfront:ListDistributions",
      "cloudfront:ListDistributionsByLambdaFunction",
      "cloudfront:ListDistributionsByWebACLId",
      "cloudfront:ListFieldLevelEncryptionConfigs",
      "cloudfront:ListFieldLevelEncryptionProfiles",
      "cloudfront:ListPublicKeys",
      "cloudfront:ListStreamingDistributions",
      "cloudfront:UpdateFieldLevelEncryptionConfig",
      "cloudfront:UpdateFieldLevelEncryptionProfile",
      "cloudfront:UpdatePublicKey",
      "cognito-idp:*",
      "dynamodb:CreateTable",
      "dynamodb:DeleteTable",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:UpdateTimeToLive",
      "ec2:AllocateAddress",
      "ec2:AssignPrivateIpAddresses",
      "ec2:AssociateAddress",
      "ec2:AttachInternetGateway",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteNetworkAcl",
      "ec2:DeleteNetworkAclEntry",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteVpc",
      "ec2:Describe*",
      "ec2:DetachInternetGateway",
      "ec2:DisassociateAddress",
      "ec2:ModifyVpcAttribute",
      "ec2:ReleaseAddress",
      "ec2:UnassignPrivateIpAddresses",
      "ecr:*",
      "es:*",
      "events:DeleteRule",
      "events:DescribeRule",
      "events:ListRuleNamesByTarget",
      "events:ListRules",
      "events:ListTargetsByRule",
      "events:PutRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "iam:AttachRolePolicy",
      "iam:CreateRole",
      "iam:CreateServiceLinkedRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteServiceLinkedRole",
      "iam:DetachRolePolicy",
      "iam:GetRole",
      "iam:GetServiceLinkedRoleDeletionStatus",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iot:CreateTopicRule",
      "iot:DeleteTopicRule",
      "iot:DisableTopicRule",
      "iot:EnableTopicRule",
      "iot:ReplaceTopicRule",
      "kinesis:CreateStream",
      "kinesis:DeleteStream",
      "kinesis:DescribeStream",
      "lambda:*",
      "logs:*",
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:PutSubscriptionFilter",
      "rds:*",
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:DescribeJob",
      "s3:GetAccelerateConfiguration",
      "s3:GetAccessPoint",
      "s3:GetAccessPointPolicy",
      "s3:GetAccessPointPolicyStatus",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetAnalyticsConfiguration",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetInventoryConfiguration",
      "s3:GetJobTagging",
      "s3:GetLifecycleConfiguration",
      "s3:GetMetricsConfiguration",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectLegalHold",
      "s3:GetObjectRetention",
      "s3:GetObjectTagging",
      "s3:GetObjectTorrent",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionTorrent",
      "s3:GetReplicationConfiguration",
      "s3:ListAccessPoints",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucketVersions",
      "s3:ListJobs",
      "s3:ListMultipartUploadParts",
      "s3:PutBucketNotification",
      "s3:PutBucketPolicy",
      "s3:PutBucketTagging",
      "s3:PutBucketWebsite",
      "s3:PutEncryptionConfiguration",
      "s3:PutObject",
      "servicediscovery:*",
      "ses:GetIdentityVerificationAttributes",
      "ses:SendEmail",
      "ses:SendRawEmail",
      "ses:VerifyEmailIdentity",
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:GetSubscriptionAttributes",
      "sns:GetTopicAttributes",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
      "sns:SetSubscriptionAttributes",
      "sns:SetTopicAttributes",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "ssm:DescribeParameters",
      "states:CreateStateMachine",
      "states:DeleteStateMachine",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "VisualEditor2"
    effect = "Allow"
    actions = [
      "ssm:AddTagsToResource",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:ListTagsForResource",
      "ssm:PutParameter",
      "ssm:RemoveTagsFromResource",
    ]
    resources = ["arn:aws:ssm:*:957221700844:parameter/crossfeed/*"]
  }
  statement {
    sid       = "VisualEditor3"
    effect    = "Allow"
    actions   = ["acm:*"]
    resources = ["arn:aws:acm:*:*:certificate/*"]
  }
  statement {
    sid     = "VisualEditor4"
    effect  = "Allow"
    actions = ["cloudfront:*"]
    resources = [
      "arn:aws:cloudfront::*:distribution/*",
      "arn:aws:cloudfront::*:origin-access-identity/*",
      "arn:aws:cloudfront::*:streaming-distribution/*",
    ]
  }
}

resource "aws_iam_policy" "crossfeed-deploy" {
  name        = "crossfeed-deploy"
  description = "A policy for deploying crossfeed"
  policy      = data.aws_iam_policy_document.crossfeed-deploy.json
}

resource "aws_iam_group_policy_attachment" "crossfeed-deploy" {
  group      = aws_iam_group.crossfeed-deploy.name
  policy_arn = aws_iam_policy.crossfeed-deploy.arn
}

resource "aws_iam_group_policy_attachment" "crossfeed-ecs-full-access" {
  group      = aws_iam_group.crossfeed-deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}
