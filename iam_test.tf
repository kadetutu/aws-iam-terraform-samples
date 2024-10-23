# This config creates an IAM role with policy to trust an extenal account for assume role action.

data "aws_iam_policy_document" "role_assume_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        var.provider_acct_arn,
      ]
      type = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "allowCE_policy_document" {
 statement {
   sid = "ceAccess"
   effect = "Allow"
   actions = [
     "ce:Describe*",
     "ce:List*",
     "ce:Get*"
   ]
   resources = ["*"]
 }
}

resource "aws_iam_policy" "allowCE_policy" {
  name = "allowCE"
  policy = data.aws_iam_policy_document.allowCE_policy_document.json
}

resource "aws_iam_policy_attachment" "allowCE_policy_document" {
  name = "allowCE_policy_attachment"
  roles = [aws_iam_role.iam_role.name]
  policy_arn = aws_iam_policy.allowCE_policy.arn
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/job-function/Billing",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSBillingConductorFullAccess"
  ])

  role = aws_iam_role.iam_role.name
  policy_arn = each.value
}

resource "aws_iam_role" "iam_role" {
  name = "SWOBillingCrossAccountRole"  
  assume_role_policy = data.aws_iam_policy_document.role_assume_policy.json  
}