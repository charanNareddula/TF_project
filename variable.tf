variable "myregion" {
   default = "us-east-2"
}
variable "wscount" {
   default = 2
}
output "instancedetails" {
   value = "${aws_instance.instance_ws.*.private_ip}"
}
output "instanceid" {
   value = "${aws_instance.instance_ws.*.id}"
}
