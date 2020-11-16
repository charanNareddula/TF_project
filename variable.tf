variable "myregion" {
   default = "us-east-2"
}
variable "wscount" {
   default = 3
}
output "private_ip_ws"{
   value = "${aws_instance.instance_ws.*.private_ip}"
}
