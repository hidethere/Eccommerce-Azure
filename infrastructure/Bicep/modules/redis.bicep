param redisName string 
param location string

resource redis 'Microsoft.Cache/Redis@2023-04-01' = {
  name: redisName
  location: location
  properties: {
  sku: {
    name: 'Basic'
    family: 'C'
    capacity: 1
  }
  enableNonSslPort: false
  publicNetworkAccess: 'Disabled' 
  }
}

var redisKeys = listKeys(redis.id, redis.apiVersion)

output primaryConnectionString string = '${redis.name}.redis.cache.windows.net:6380,password=${redisKeys.primaryKey},ssl=True,abortConnect=False'
output redisId string = redis.id
