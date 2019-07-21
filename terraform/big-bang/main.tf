
resource "packet_ssh_key" "diogo_key" {
  name       = "diogo"
  public_key = "${file("/home/diogo/.ssh/id_rsa.pub")}"
}

resource "packet_project" "proj" {
  name            = "${var.project}"
  organization_id = "${var.organization_id}"
}