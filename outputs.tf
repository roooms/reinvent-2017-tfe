output "demo1-public-ipv4" {
  value = "${aws_instance.demo1.public_ip}"
}

output "demo2-public-ipv4" {
  value = "${aws_instance.demo2.public_ip}"
}
