param location string = 'uksouth'
param workload string = 'default'
@allowed(['dev', 'test', 'prod'])
param env string


resource containerApp 'Microsoft.App/containerApps@2026-07-01' = {
  name: 'ca-${workload}-${env}-${location}'
  location: location
  properties: {
  }
}
