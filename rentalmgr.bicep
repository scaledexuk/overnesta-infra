targetScope = 'subscription'

@description('Short workload name, e.g. rentalmgr')
param workload string

@allowed(['dev', 'test', 'prod'])
param env string

param location string = 'uksouth'

@description('Tags')
param tags object = {}

var rgName = 'rg-${workload}-${env}-${location}'

var allTags = union(tags, {
  workload: workload
  env: env
  managedBy: 'bicep'
})

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: location
  tags: allTags
}

module staticApp 'modules/static-app.bicep' = {
  name: 'staticAppDeploy'
  scope: rg
  params: {
    workload: workload
    env: env
  }
}

resource sharedEnvironment 'Microsoft.App/managedEnvironments@2026-07-01' existing = {
  name: 'cae-overnesta-${env}'
  scope: resourceGroup('rg-overnesta-${env}-${location}')
}

module containerApp 'modules/container-apps.bicep' = {
  name: 'containerAppDeploy'
  scope: rg
  params: {
    name: 'ca-${workload}-${env}'
    location: location
    environmentId: sharedEnvironment.id
    tags: allTags
  }
}



