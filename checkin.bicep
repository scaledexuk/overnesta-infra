targetScope = 'subscription'

@description('Short workload name, e.g. overnesta-checkin')
param workload string

@allowed(['dev', 'test', 'prod'])
param env string

param location string = 'uksouth'
