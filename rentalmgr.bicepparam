using './rentalmgr.bicep'

param workload = 'overnesta-rentalmgr'

param env = 'dev'
param location = 'uksouth'
param tags = {
  owner: 'emsto'
}
