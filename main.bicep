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


module serviceBus 'modules/service-bus.bicep' = {
  name: 'serviceBusDeploy'
  scope: rg
  params: {
    workload: workload
    location: location
    env: env
  }
}

output resourceGroupName string = rg.name
output resourceGroupId string = rg.id
output serviceBusNamespace string = serviceBus.outputs.serviceBusNamespace
output fileProcessingQueueRequest string = serviceBus.outputs.fileProcessingQueueRequest
output fileProcessingQueueResponse string = serviceBus.outputs.fileProcessingQueueResponse
