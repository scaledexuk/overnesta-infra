using './overnesta.bicep'

param workload = 'overnesta'

param env = 'dev'
param location = 'uksouth'
param tags = {
  owner: 'emsto'
}
