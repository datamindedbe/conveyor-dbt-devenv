locals {
  project_name = "dbt-devenv"
  uuid_pattern = "????????-????-????-????-????????????"
}

resource "aws_iam_role" "default" {
  name               = "${local.project_name}-${var.env_name}"
  assume_role_policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringLike"
      variable = "${replace(var.aws_iam_openid_connect_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.env_name}:${replace(local.project_name, "_", ".")}-${local.uuid_pattern}"]
    }

    principals {
      identifiers = [var.aws_iam_openid_connect_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role_policy" "dbt" {
  name   = "dbt"
  role   = aws_iam_role.default.id
  policy = data.aws_iam_policy_document.dbt.json
}

data "aws_iam_policy_document" "dbt" {
  statement {
    actions = [
      "secretsmanager:*"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}