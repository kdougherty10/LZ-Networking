/*
resource "azurerm_network_security_group" "nsg-1" {
  name                  = local.settings.nsg-1
  location              = azurerm_resource_group.hub.location
  resource_group_name   = azurerm_resource_group.hub.name
  tags                  = local.settings.tags
}

resource "azurerm_network_security_rule" "securityrule-1" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name   = azurerm_resource_group.hub.name
  network_security_group_name = azurerm_network_security_group.nsg-1.name
}

resource "azurerm_network_security_group" "nsg-2" {
  name                  = local.settings.nsg-2
  location              = azurerm_resource_group.hub.location
  resource_group_name   = azurerm_resource_group.hub.name
  tags                  = local.settings.tags
}

resource "azurerm_network_security_rule" "securityrule-2" {
  name                        = "test321"
  priority                    = 120
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name   = azurerm_resource_group.hub.name
  network_security_group_name = azurerm_network_security_group.nsg-2.name
}

resource "azurerm_network_security_group" "nsg-3" {
  name                  = local.settings.nsg-3
  location              = azurerm_resource_group.hub.location
  resource_group_name   = azurerm_resource_group.hub.name
  tags                  = local.settings.tags
}

resource "azurerm_network_security_rule" "securityrule-3" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name   = azurerm_resource_group.hub.name
  network_security_group_name = azurerm_network_security_group.nsg-2.name
}

resource "azurerm_subnet_network_security_group_association" "nsgassociation1" {
  subnet_id                 = "${azurerm_subnet.addsubnet.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg-1.id}"
}

resource "azurerm_subnet_network_security_group_association" "nsgassociation2" {
  subnet_id                 = "${azurerm_subnet.adminsubnet.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg-2.id}"
}
resource "azurerm_subnet_network_security_group_association" "nsgassociation3" {
  subnet_id                 = "${azurerm_subnet.webappfirewallsubnet.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg-3.id}"
}
*/