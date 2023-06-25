# Create Virtual Machine

resource "azurerm_public_ip" "mo-dev-ado-pip" {
  name                = var.vm_pip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.moado.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "mo-dev-ado-nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.moado.location
  resource_group_name = azurerm_resource_group.moado.name

  ip_configuration {
    name                          = "ip"
    subnet_id                     = azurerm_subnet.subnet_name_ado_agent.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm_private_ip_address
    public_ip_address_id          = azurerm_public_ip.mo-dev-ado-pip.id
  }
}

resource "azurerm_virtual_machine" "mo-ado-vm" {
  name                             = "${var.vm_name}-vm"
  location                         = azurerm_resource_group.moado.location
  resource_group_name              = azurerm_resource_group.moado.name
  network_interface_ids            = [azurerm_network_interface.mo-dev-ado-nic.id]
  vm_size                          = "Standard_B2s"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"

  storage_os_disk {
    name              = var.vm_osdisk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


  os_profile {
    computer_name  = "${var.vm_name}-vm"
    admin_username = var.vm_username
    admin_password = random_password.password.result
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


resource "azurerm_virtual_machine_extension" "update-vm" {
  name                 = "hostname"
  virtual_machine_id   = azurerm_virtual_machine.mo-ado-vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "script": "${base64encode(file("${path.module}/scripts/script.sh"))}"
 }
SETTINGS
}

