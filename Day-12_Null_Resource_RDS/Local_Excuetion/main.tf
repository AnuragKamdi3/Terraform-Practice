resource "aws_secretsmanager_secret" "db_credentials-v1" {
    name = "mysql-db-credentials-v1"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
    secret_id     = aws_secretsmanager_secret.db_credentials-v1.id
    secret_string = jsonencode({
        username = "admin"
        password = "#Password123"
    })
}

locals {
    db_credentials = jsondecode(aws_secretsmanager_secret_version.db_credentials_version.secret_string)
}

# Create the RDS instance
resource "aws_db_instance" "mysql_rds" {
    identifier              = "my-mysql-db"
    engine                  = "mysql"
    instance_class          = "db.t3.micro"
    username                = local.db_credentials.username
    password                = local.db_credentials.password
    db_name                 = "mydb"
    allocated_storage       = 20
    skip_final_snapshot     = true
    publicly_accessible     = true
}

# Use null_resource to execute the SQL script from your local machine
resource "null_resource" "local_sql_exec" {
    depends_on = [aws_db_instance.mysql_rds]

    provisioner "local-exec" {
        command = "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -p#Password123 mydb < test.sql"
    }

    triggers = {
        always_run = timestamp()
    }
}