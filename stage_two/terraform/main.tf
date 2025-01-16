provider "virtualbox" {}

resource "virtualbox_vm" "ecommerce" {
  name   = "ecommerce_vm"
  cpus   = 2
  memory = 2048
}

provisioner "local-exec" {
  command = "ansible-playbook -i ../ansible/inventory/hosts ../ansible/playbook.yml"
}
