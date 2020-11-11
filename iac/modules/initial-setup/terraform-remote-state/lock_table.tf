resource "aws_dynamodb_table" "lock_table" {
  hash_key     = "LockID"
  name         = "terraform_lock_table"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
}