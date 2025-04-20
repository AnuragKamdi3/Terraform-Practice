resource "aws_vpc" "DEV" {
    cidr_block = "10.0.0.0/16"

}
resource "aws_subnet" "SN-1" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.DEV.id
}
resource "aws_subnet" "SN-3" {
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.DEV.id
}