resource "aws_s3_bucket" "bucket_projeto_cyber" {
  bucket = "meu-lab-vulneravel-2025"
}

# ERRO CRÍTICO: ACL pública permite leitura por qualquer pessoa na web
resource "aws_s3_bucket_acl" "perigo" {
  bucket = aws_s3_bucket.bucket_projeto_cyber.id
  acl    = "public-read"
}
