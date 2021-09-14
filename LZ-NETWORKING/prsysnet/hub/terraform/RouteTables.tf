
/*
resource "azurerm_route_table" "publicroutetable" {
name = local.settings.routetable.routetablename
location = azurerm_resource_group.hub.location
resource_group_name = azurerm_resource_group.hub.name
route {
name = local.settings.routetable.routename
address_prefix = local.settings.routetable.routeaddressprefix
next_hop_type = local.settings.routetable.routenexthop
next_hop_in_ip_address = local.settings.routetable.routenexthopaddress
}
}
resource "azurerm_subnet_route_table_association" "RouteAssociation" {
subnet_id = data.azurerm_subnet.addssubnet[0].id
route_table_id = azurerm_route_table.publicroutetable.id
}



resource "azurerm_route" "hubRouteToSpoke" {
  name                   = "HubVNet-to-Firewall"
  resource_group_name    = azurerm_resource_group.networking.name
  route_table_name       = azurerm_route_table.public_route_table.name
  address_prefix         = local.settings.addressprefix
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = local.settings.nexthop
}

*/
