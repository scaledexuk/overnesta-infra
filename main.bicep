targetScope = 'subscription'

@description('Short workload name, e.g. overnesta')
param workload string

@allowed(['dev', 'test', 'prod'])
param env string

param location string = 'uksouth'

param tags object = {}

var rgName = 'rg-${workload}-${env}-${location}'

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: location
  tags: union(tags, {
    workload: workload
    env: env
    managedBy: 'bicep'
  })
}

output resourceGroupName string = rg.name
output resourceGroupId string = rg.id
