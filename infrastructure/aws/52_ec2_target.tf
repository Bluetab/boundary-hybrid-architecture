# Example resource for connecting to through boundary over SSH
resource "aws_instance" "target" {
  count                  = var.num_targets
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.*.id[count.index]
  key_name               = aws_key_pair.boundary.key_name
  vpc_security_group_ids = [aws_security_group.worker.id]

  tags = merge(var.tags, {
    Name = format("%s-target", var.name)
  })
}
