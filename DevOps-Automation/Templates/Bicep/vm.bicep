resource vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: 'myVm'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: 'myVm'
      adminUsername: 'azureuser'
      adminPassword: 'ReplaceWithSecurePassword123!'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', 'myNic')
        }
      ]
    }
  }
}