

resource "azurerm_public_ip" "azfirewallpip" {
  name                = local.settings.azfirewallpip
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = local.settings.ipallocation
  availability_zone = "No-Zone"
  sku                 = local.settings.azfirewallsku
  tags                = local.settings.tags
}

resource "azurerm_firewall" "azurefirewall" {
  name                = local.settings.azfirewallname
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_tier  = "Premium"
  #count               = local.settings["resource_enabled"] ? 1 : 0
  #dns_servers         = local.settings.dnsip 
  tags = local.settings.tags

  ip_configuration {
    name                 = local.settings.ipconfig
    subnet_id            = azurerm_subnet.azurefirewallsubnet.id
    public_ip_address_id = azurerm_public_ip.azfirewallpip.id
  }
}
/*
resource "azurerm_firewall_network_rule_collection" "fw-nr-dev" {
  name                = "Dev-Rules"
  azure_firewall_name = azurerm_firewall.azurefirewall.name
  resource_group_name = azurerm_resource_group.hub.name
  priority            = 113
  action              = "Allow"

  rule {
    name = "Corp-to-Hub"

    source_addresses = [
      "10.0.0.0/8",
      "172.16.0.0/12",

    ]

    destination_ports = [
      "80",
      "443",
      "22",
      "3389",
    ]

    destination_addresses = [
      "${local.settings.location_cidr}.0.0/16",

    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }

}

resource "azurerm_firewall_network_rule_collection" "fw-nr-global" {
  name                = "Global-Rules"
  azure_firewall_name = azurerm_firewall.azurefirewall.name
  resource_group_name = azurerm_resource_group.hub.name
  priority            = 5650
  action              = "Allow"

  rule {
    name = "Global-HubDNS-Inbound"
    source_addresses = [
      "10.0.0.0/8",
      "172.16.0.0/12",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "${local.settings.location_cidr}.1.32",
      "${local.settings.location_cidr}.1.33",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }

  rule {
    name = "Global-KMS-Outbound"
    source_addresses = [
      "10.0.0.0/8",
      "172.16.0.0/12",
    ]

    destination_ports = [
      "1688",
    ]

    destination_addresses = [
      "23.102.135.246"
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }

  rule {
    name             = "AzureMonitor"
    source_addresses = ["*"]

    destination_ports = [
      "443",
    ]

    destination_addresses = [
      "AzureMonitor"
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
  rule {
    name = "Global-TimeService-Outbound"

    source_addresses = [
      "10.0.0.0/8",
      "172.16.0.0/12"
    ]

    destination_addresses = [
      "13.86.101.172"
    ]

    destination_ports = [
      "123",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }

  
    rule {
    name = "Gateway-Subnet-NetworkRules"

    source_addresses = ["${local.settings.gatewaysubnet_prefix}"]

    destination_ports = [
      "53",
    ]

    destination_addresses = ["${local.settings.gatewaysubnet_prefix}"]

    protocols = [
      "TCP",
      "UDP",
    ]
  }

}

resource "azurerm_firewall_application_rule_collection" "fw-ar-global-login" {
  name                = "Global-Microsoft-Login-Rules"
  azure_firewall_name = azurerm_firewall.azurefirewall.name
  resource_group_name = azurerm_resource_group.hub.name
  priority            = 5651
  action              = "Allow"

  rule {
    name = "URLs to support sign in and licensing connections"

    source_addresses = [
      "*",
    ]    

    target_fqdns = [
      "login.microsoftonline.com",
      "management.core.windows.net",
      "login.microsoftonline.com",
      "login.live.com",
      "go.microsoft.com",
      "graph.microsoft.com",
      "app.vssps.dev.azure.com",
      "app.vssps.visualstudio.com",
      "aadcdn.msauth.net",
      "aadcdn.msftauth.net",
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "Additional URLs for signing into Azure DevOps and Azure"

    source_addresses = [
      "*",
    ]
   
    target_fqdns = [
      "amcdn.msftauth.net",
      "windows.net", "microsoftonline.com",
      "visualstudio.com",
      "microsoft.com",
      "live.com",
      "dev.azure.com",
      "azure.microsoft.com",
      "management.azure.com",
      "azurecomcdn.azureedge.net",
      "amp.azure.net",
      "aexprodea1.vsaex.visualstudio.com",
      "management.core.windows.net",
      "aex.dev.azure.com",
      "app.vssps.dev.azure.com",
      "app.vssps.visualstudio.com",
      "vstsagentpackage.azureedge.net",
      "cdn.vsassets.io",
      "gallerycdn.vsassets.io",
      "static2.sharepointonline.com",
      "*.vstmrblob.vsassets.io",
      "vsrm.dev.azure.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "Additional domains"

    source_addresses = [
      "*",
    ]

    target_fqdns = [
      "*.vsassets.io",
      "*.vsassetscdn.azure.cn",
      "*.gallerycdn.vsassets.io",
      "*.gallerycdn.azure.cn",

    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "Artifacts"

    source_addresses = [
      "*",
    ]

    target_fqdns = [
      "*.blob.core.windows.net",
      "*.visualstudio.com",

    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "NuGet connections"

    source_addresses = [
      "*",
    ]

    target_fqdns = [
      "azurewebsites.net",
      "nuget.org",

    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "SSH connections"

    source_addresses = [
      "*",
    ]

    target_fqdns = [
      "ssh.dev.azure.com",
      "vs-ssh.visualstudio.com",

    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }


}

*/