provider "aws" {
  access_key          = "${var.access_key}"
  secret_key          = "${var.secret_key}"
  allowed_account_ids = ["${var.first_account_id}"]
  region              = "${var.region}"
  #version             = ">= 3.0"
}
variable "access_key" {}
variable "secret_key" {}
variable "first_account_id" {
  type  = string
}
variable "region" {
  type  = string
}
variable "ami" {
  type    = string
  default = "ami-0ec6517f6edbf8044"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
resource "aws_vpc" "vpcByTFE" {
  cidr_block  = "10.0.0.0/16"
}
resource "aws_subnet" "subnetByTFE" {
  vpc_id      = "${aws_vpc.vpcByTFE.id}"
  cidr_block  = "10.0.1.0/24"
}
resource "aws_network_interface" "nicByTFE" {
  subnet_id = "${aws_subnet.subnetByTFE.id}"
}
resource "aws_instance" "ec2ByTFE" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  network_interface {
    network_interface_id = "${aws_network_interface.nicByTFE.id}"
    device_index         = 0
  }
}
