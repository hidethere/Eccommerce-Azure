param sbNameSpace string 
param location string

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2024-01-01' = {
  name: sbNameSpace
  location: location
  sku: {
    name: 'Premium'
    tier: 'Premium'
    capacity: 1 
  }
  properties: {
    publicNetworkAccess: 'Disabled'
  }
}

resource sbAuthRule 'Microsoft.ServiceBus/namespaces/authorizationRules@2022-10-01-preview' existing = {
  name: 'RootManageSharedAccessKey'
  parent: serviceBusNamespace
}



output serviceBusNamespaceId string = serviceBusNamespace.id
var sbKeys = listKeys(sbAuthRule.id, sbAuthRule.apiVersion)
output serviceBusConnectionString string = sbKeys.primaryConnectionString
