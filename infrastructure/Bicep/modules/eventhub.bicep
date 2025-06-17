param location string
param eventHubNameSpace string 
//param schemaRegistryName string

resource eventHubNamespace 'Microsoft.EventHub/namespaces@2022-10-01-preview' = {
  name: eventHubNameSpace
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    isAutoInflateEnabled: false
    kafkaEnabled: true
    zoneRedundant: false
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
  }
}

/*
resource schemaRegistry 'Microsoft.EventHub/namespaces/schemas@2022-10-01-preview' = {
  parent: eventHubNamespace
  name: schemaRegistryName
  location: location
  properties: {}
}



output schemaRegistryId string = schemaRegistry.id */

// Get default authorization rule (RootManageSharedAccessKey)
resource authRule 'Microsoft.EventHub/namespaces/authorizationRules@2022-10-01-preview' existing = {
  name: '${eventHubNamespace.name}/RootManageSharedAccessKey'
}

// Use listKeys to get connection strings from the auth rule
var keys = listKeys(authRule.id, authRule.apiVersion)

output eventHubConnectionString string = keys.primaryConnectionString
output eventHubNamespaceId string = eventHubNamespace.id
