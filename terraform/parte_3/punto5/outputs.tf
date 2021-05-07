output "public-instance-ip" {
  value = "${aws_instance.servidor-web.public_ip}"
}