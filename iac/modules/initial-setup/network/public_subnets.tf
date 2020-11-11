resource "aws_subnet" "public_subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "pubic-subnet-${each.key}"
  }
}
