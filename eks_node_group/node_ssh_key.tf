resource "aws_key_pair" "node_ssh_key" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJ5fVCcquF7jTlHjm68qAvYSxSUcDhZrdaKYG7nJRAa1P0MCv+0NFSx4wU6vRupymlOt15wH+1MKwMzRYSg/nS5mBT8MJPWfx6q9tRNe2A3+Nxx8GdD4QbF9pBT7V51EBvk+2Qh1D1CMvN/3M8HIbHT0BKaIsQnmdwKEKfMlZ7YWTbsgEGF7EhJZg1IdhAGhWzeaGQA/MPizKJmdZlfY2ivl8qdEDpKFRjzY90g8QmxZED3RdqAJZWBEi6ZnKpI44tPMo3PXP1rfa3vogDarqHlnCKfySvSiIsHHfDuy5DfBpoQ3XmLtxbHOB73Zc688ZTWGChY+Dhz+pc3CFgOINARgrxHmvly6KAfRhr+QehojSNkuIjJyB6ufNbBZKMnV0Ju8z98SLFkMUojv7LgFwiU6iMziNcHVq628+XoFGJW83jEOQ8aqUjWwbSWkIDEcCdVEoi7aQWJuSMYhUJ74CS36S1BnPvam7ioXJiIgkFGO/D7I9zrCXWcoyMYhfERNE= larry@asiq.ai"
  key_name   = var.nodegroup_keypair
}