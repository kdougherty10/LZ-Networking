# Create a virtual network within the resource group
resource "azurerm_virtual_network" "net-vnet" {
  name                = local.settings.netvnet
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  address_space       = local.settings.address_space
  tags                  = local.settings.tags
  
}

 resource "azurerm_subnet" "adminsubnet" {
  name                 = local.settings.adminsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.adminaddress_prefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
  }

 resource "azurerm_subnet" "addsubnet" {
  name                 = local.settings.addsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.addsaddress_prefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
  }

  resource "azurerm_subnet" "gatewaysubnet" {
  name                 = local.settings.gatewaysubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.gatewaysubnet_prefix
 }

resource "azurerm_subnet" "azurefirewallsubnet" {
  name                 = local.settings.azurefirewallsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.azurefirewallsubnet_prefix
  
  }

  resource "azurerm_subnet" "storagesubnet" {
  name                 = local.settings.azurestoragesubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.azurestoragesubnet_prefix
  
  }

resource "azurerm_subnet" "kvsubnet" {
  name                 = local.settings.kvsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.kvaddress_prefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
  }

/*resource "azurerm_subnet" "webappfirewallsubnet" {
  name                 = local.settings.webappfirewallsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.webappfirewall_prefix
  
  }*/

/*

resource "azurerm_subnet" "panmgmtsubnet" {
  name                 = local.settings.panmgmtsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.palofirewall_prefix
  
  }

resource "azurerm_subnet" "panzone1subnet" {
  name                 = local.settings.panzone1subnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.zone1_address_space
  
  }

resource "azurerm_subnet" "panzone2subnet" {
  name                 = local.settings.webappfirewallsubnet
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefix       = local.settings.zone2_address_space
  
  }



  resource "azurerm_management_lock" "vnetlock" {
  name       = "${local.settings.lock}"
  scope      = azurerm_virtual_network.net-vnet.id
  lock_level = local.settings.lock_level
  notes      = local.settings.notes
}

*/