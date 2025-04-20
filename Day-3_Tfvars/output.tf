output "IP" {
    value = aws_instance.TEST1.public_ip

}
output "IP-1" {
    value = aws_instance.TEST2.public_ip

}