resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'mystorageacct${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}