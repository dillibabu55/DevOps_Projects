resource "aws_key_pair" "terraform_key" {

  key_name   = "terraform-key"

  public_key = file(var.public_key_path)

}
