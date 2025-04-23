output "instance_public_ip" {
    value = aws_instance.E2_Made_Using_TF.public_ip
    sensitive = true
}

output "instance_id"{
    value = aws_instance.E2_Made_Using_TF.id
}
output "instance_public_dns" {
    value = aws_instance.E2_Made_Using_TF.public_dns
}
output "instance_arn" {
    value = aws_instance.E2_Made_Using_TF.arn
}