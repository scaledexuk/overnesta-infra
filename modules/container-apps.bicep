@description('Container App name, max 32 chars, e.g. ca-overnesta-checkin-dev')
@maxLength(32)
param name string

param location string = resourceGroup().location

param tags object = {}

@description('Resource ID of the Container Apps environment (created in shared.bicep)')
param environmentId string

@description('Port the container listens on. Quickstart = 80, Overnesta API = 8080.')
param targetPort int = 80

@description('Image to run. Public placeholder until your own image is pushed.')
param image string = 'mcr.microsoft.com/k8se/quickstart:latest'

resource containerApp 'Microsoft.App/containerApps@2026-07-01' = {
  name: name
  location: location
  tags: tags

  properties: {
    managedEnvironmentId: environmentId
    configuration: {
      ingress: {
        external: true
        targetPort: targetPort
      }
    }
    template: {
      containers: [
        {
          name: 'app'
          image: image
          resources: {
            cpu: json('0.25')
            memory: '0.5Gi'
          }
        }
      ]
      scale: {
        minReplicas: 0
        maxReplicas: 1
      }
    }
  }
}

output url string = 'https://${containerApp.properties.configuration.ingress.fqdn}'
