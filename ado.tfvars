# Create Resource Group
rg_name = "mo-dev-ado-project"

# Create Virtual Network
vnet_name                     = "mo-dev-ado-agent-vnet"
vnet_ip_address               = ["192.168.0.0/16"]
subnet_name_ado_agent         = "ado-agent-subnet"
subnet_name_ado_agent_address = "192.168.0.0/24"

# Key Vault
key_vault_name = "mo-dev-ado-kv"

# Create Virtual Machine
vm_name               = "mo-dev-ado"
vm_private_ip_address = "192.168.0.4"
vm_pip_name           = "mo-dev-ado-agent-pip"
vm_username           = "modev"
vm_osdisk_name        = "mo-dev-ado-vm-osdisk"

# Network Security Group
nsg_name = "mo-dev-ado-vm-nsg"