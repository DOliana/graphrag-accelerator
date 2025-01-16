// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

@description('Name of the NSG for the API Management service.')
param nsgName string = 'aks-nsg-${uniqueString(resourceGroup().id)}'

@description('Azure region where the resources will be deployed')
param location string = resourceGroup().location

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allo_all_inbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'Allow_all_outbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 100
          direction: 'Outbound'
        }
      }
    ]
  }
}

output id string = nsg.id
