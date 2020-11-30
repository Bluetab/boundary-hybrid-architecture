resource "aws_iam_role" "boundary" {
  name = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_iam_instance_profile" "boundary" {
  name = var.name
  role = aws_iam_role.boundary.name
}

resource "aws_iam_role_policy" "boundary" {
  name = var.name
  role = aws_iam_role.boundary.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:ListKeys",
      "kms:ListAliases"
    ],
    "Resource": [
      "${aws_kms_key.root.arn}",
      "${aws_kms_key.worker_auth.arn}",
      "${aws_kms_key.recovery.arn}"
    ]
  }
}
EOF
}

resource "aws_iam_user" "gcp_worker" {
  name = "${var.name}-gcp-worker"

  tags = merge(var.tags, {
    Name = "${var.name}-gcp-worker"
  })
}

resource "aws_iam_access_key" "gcp_worker" {
  user = aws_iam_user.gcp_worker.name
}

resource "aws_iam_policy" "gcp_worker" {
  name        = "${var.name}-gcp-worker"
  description = "Boundary gcp worker policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:ListKeys",
      "kms:ListAliases"
    ],
    "Resource": [
      "${aws_kms_key.root.arn}",
      "${aws_kms_key.worker_auth.arn}",
      "${aws_kms_key.recovery.arn}"
    ]
  }
}
EOF
}

resource "aws_iam_user_policy_attachment" "gcp_worker" {
  user       = aws_iam_user.gcp_worker.name
  policy_arn = aws_iam_policy.gcp_worker.arn
}

