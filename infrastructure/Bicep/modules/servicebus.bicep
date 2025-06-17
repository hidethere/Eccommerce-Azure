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

resource sbNamespaceAuthRule 'Microsoft.ServiceBus/namespaces/authorizationRules@2024-01-01' = {
  parent: serviceBusNamespace
  name: 'RootManageSharedAccessKey'
  properties: {
    rights: [
      'Listen'
      'Send'
      'Manage'
    ]
  }
}

resource sbNamespaceAuthRuleKeys 'Microsoft.ServiceBus/namespaces/authorizationRules/listKeys@2024-01-01' = {
  parent: sbNamespaceAuthRule
  name: 'listKeys'
}

output serviceBusConnectionString string = sbNamespaceAuthRuleKeys.properties.primaryConnectionString
output serviceBusNamespaceId string = serviceBusNamespace.id
