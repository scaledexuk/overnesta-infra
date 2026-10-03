
param location string = 'uksouth'
@description('Short workload name, e.g. overnesta')
param workload string

@allowed(['dev', 'test', 'prod'])
param env string

var sbName = 'sb-${workload}-${env}'

resource sbNamespace 'Microsoft.ServiceBus/namespaces@2026-01-01' = {
  name: sbName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource fileProcessingQueueRequest 'Microsoft.ServiceBus/namespaces/queues@2026-01-01' = {
  parent: sbNamespace
  name: 'file-processing-request'
}

resource fileProcessingQueueResponse 'Microsoft.ServiceBus/namespaces/queues@2026-01-01' = {
  parent: sbNamespace
  name: 'file-processing-response'
}

 output serviceBusNamespace string = sbNamespace.name
 output fileProcessingQueueRequest string = fileProcessingQueueRequest.name
 output fileProcessingQueueResponse string = fileProcessingQueueResponse.name
