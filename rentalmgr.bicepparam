using './rentalmgr.bicep'

param workload = 'rentalmgr'

param env = 'dev'
param location = 'uksouth'
param tags = {
  owner: 'emsto'
}
