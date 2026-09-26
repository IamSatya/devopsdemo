# AWS OpenID Connect (OIDC) Identity Provider & IAM Role Configuration
# Account ID: 471112662115 | Repository: IamSatya/devopsdemo

# 1. GitHub OIDC Provider in AWS IAM
resource "aws_iam_openid_connect_provider" "github_oidc" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a21a81e5b27e16310709d73d6b051a66ff5c"]
}

# 2. IAM Role Assumed Keylessly by GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-pulsecare-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::471112662115:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:IamSatya/devopsdemo:ref:refs/heads/*"
          }
        }
      }
    ]
  })
}

# 3. Attach Permissions
resource "aws_iam_role_policy_attachment" "ec2_full" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_full" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "dynamodb_full" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}
