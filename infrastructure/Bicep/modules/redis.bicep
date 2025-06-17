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


var redisHost = redis.properties.hostName
var redisKey = listKeys(redis.id, redis.apiVersion).primaryKey
output redisConnectionString string  = '${redisHost},password=${redisKey},ssl=True,abortConnect=False'
output redisId string = redis.id
