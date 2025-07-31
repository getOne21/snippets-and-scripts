param siteName string = 'mywebapp'
param hostingPlanName string = 'myAppServicePlan'

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: resourceGroup().location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: siteName
  location: resourceGroup().location
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
  dependsOn: [
    hostingPlan
  ]
}