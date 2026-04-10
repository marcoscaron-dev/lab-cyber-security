resource "aws_s3_bucket" "secure_bucket" {
  bucket = "meu-bucket-treinamento-seguranca-fix"

  # checkov:skip=CKV_AWS_144:Sem replicacao regional por enquanto
  # checkov:skip=CKV_AWS_18:Logging nao habilitado para este lab
  # checkov:skip=CKV_AWS_145:Usando AES256 em vez de KMS (simplificacao)
  # checkov:skip=CKV2_AWS_61:Ciclo de vida sera definido depois
  # checkov:skip=CKV2_AWS_62:Notificacoes de evento desativadas
}

# Bloqueio de acesso público (que já tínhamos feito)
resource "aws_s3_bucket_public_access_block" "secure_block" {
  bucket                  = aws_s3_bucket.secure_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Criptografia básica (que já tínhamos feito)
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_crypto" {
  bucket = aws_s3_bucket.secure_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# NOVO: Correção do Versionamento (CKV_AWS_21)
resource "aws_s3_bucket_versioning" "secure_versioning" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
