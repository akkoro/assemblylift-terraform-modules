terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

variable project_name {
  type = string
  description = "The AssemblyLift project name in which the service resides"
}

variable service {
  type = string
  description = "The name of the AssemblyLift service in which the function resides"
}

variable function {
  type = string
  description = "The name of the AssemblyLift function to attach the policy to"
}

variable policy {
  type = string
  description = "The IAM policy contents"
}

data aws_iam_role role {
  provider = aws
  name     = "asml-${var.project_name}-${var.service}-${var.function}"
}

resource aws_iam_policy policy {
  provider = aws

  name = "asml-${var.project_name}-usermod-${var.service}-${var.function}"
  path = "/"

  policy = var.policy
}

resource aws_iam_role_policy_attachment www_server_invoke_policy_attachment {
  provider   = aws
  role       = data.aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

