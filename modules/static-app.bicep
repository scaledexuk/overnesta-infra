param location string = 'westeurope'
@description('Short workload name, e.g. overnesta')
param workload string

@allowed(['dev', 'test', 'prod'])
param env string

var staticAppName = 'static-app-${workload}-${env}'

resource staticSite 'Microsoft.Web/staticSites@2021-02-01' = {
  name: staticAppName
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {}
}
