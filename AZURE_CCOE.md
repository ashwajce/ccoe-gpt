# Azure CCOE Environment - Complete Reference

## Regional Constraints

### Kubernetes (AKS)
- **Region**: West Europe
- **Location Code**: `westeurope`
- **Note**: This is the ONLY supported region for AKS clusters in the CCOE environment
- **Availability Zones**: 3 zones available (1, 2, 3)
- **Node VM Sizes**: Standard_D4s_v3, Standard_D8s_v3, Standard_D16s_v3

### App Services
- **Region**: West Germany
- **Location Code**: `germanywestcentral`
- **Note**: This is the ONLY supported region for App Services in the CCOE environment
- **Pricing Tiers**: Basic (B1, B2, B3), Standard (S1, S2, S3), Premium (P1v2, P2v2, P3v2)
- **Runtime Support**: .NET 6/7/8, Node.js 16/18/20, Python 3.9/3.10/3.11, Java 11/17

## Supported Services by Region

### West Europe (Kubernetes)
- **Azure Kubernetes Service (AKS)**: ✅ Primary compute platform
- **Azure Container Registry (ACR)**: ✅ For container images
- **Azure Key Vault**: ✅ For secrets management
- **Azure Monitor**: ✅ For logging and monitoring
- **Azure Load Balancer**: ✅ Standard SKU only
- **Azure Storage**: ✅ Standard and Premium tiers
- **Azure Virtual Network**: ✅ With NSG support

### West Germany (App Services)
- **Azure App Service**: ✅ Web apps and APIs
- **Azure Functions**: ✅ Serverless compute
- **Azure SQL Database**: ✅ Managed database
- **Azure Cosmos DB**: ✅ NoSQL database
- **Azure Redis Cache**: ✅ For caching
- **Application Insights**: ✅ For monitoring

## Networking Configuration

### West Europe (AKS)
- **VNet Address Space**: 10.240.0.0/16
- **AKS Subnet**: 10.240.0.0/20
- **Service Subnet**: 10.240.16.0/24
- **DNS**: Azure-provided DNS (168.63.129.16)
- **Outbound Type**: Load Balancer
- **Network Policy**: Azure CNI with Calico

### West Germany (App Services)
- **VNet Integration**: Supported via regional VNet integration
- **Private Endpoints**: Supported for secure access
- **Hybrid Connections**: Available for on-premises connectivity

## Storage Options

### West Europe
- **Azure Blob Storage**: Standard (LRS, GRS), Premium (LRS)
- **Azure Files**: Standard and Premium tiers
- **Persistent Volumes**: Azure Disk (Standard SSD, Premium SSD)
- **Storage Classes**: managed-premium, managed-standard

### West Germany
- **Azure Blob Storage**: Standard (LRS, GRS)
- **Azure Files**: Standard tier only
- **Backup Storage**: GRS recommended

## Security & Compliance

### Authentication
- **Azure AD Integration**: Required for all services
- **Managed Identities**: Preferred for service-to-service auth
- **Service Principals**: Allowed with approval

### Network Security
- **NSG Rules**: Required for all subnets
- **Private Endpoints**: Mandatory for production databases
- **TLS Version**: Minimum TLS 1.2
- **Firewall**: Azure Firewall in West Europe hub

### Compliance
- **Data Residency**: All data must stay in EU
- **Encryption**: At-rest encryption mandatory
- **Audit Logging**: Azure Monitor required

## Resource Naming Convention

```
{environment}-{service}-{region}-{instance}

Examples:
- prod-aks-weu-01 (AKS in West Europe)
- prod-app-gwc-api (App Service in West Germany)
- dev-acr-weu-shared (Container Registry in West Europe)
```

## Cost Optimization

### West Europe (AKS)
- **Node Pools**: Use spot instances for dev/test (up to 80% savings)
- **Auto-scaling**: Enable cluster autoscaler (min: 2, max: 10 nodes)
- **Reserved Instances**: 1-year commitment for production (30% savings)

### West Germany (App Services)
- **App Service Plans**: Share plans across multiple apps
- **Auto-scaling**: Configure based on CPU/memory metrics
- **Dev/Test Pricing**: Available for non-production environments

## Deployment Guidelines

### For Kubernetes (AKS) - West Europe
```bash
az aks create \
  --resource-group ccoe-prod-rg \
  --name prod-aks-weu-01 \
  --location westeurope \
  --node-count 3 \
  --node-vm-size Standard_D4s_v3 \
  --network-plugin azure \
  --enable-managed-identity
```

### For App Services - West Germany
```bash
az webapp create \
  --resource-group ccoe-prod-rg \
  --plan prod-asp-gwc-01 \
  --name prod-app-gwc-ccoegpt \
  --runtime "NODE:18-lts" \
  --location germanywestcentral
```

## Monitoring & Alerts

### Required Metrics
- **AKS**: CPU utilization, memory usage, pod count, node health
- **App Services**: Response time, HTTP errors, CPU percentage, memory percentage
- **Databases**: DTU/vCore usage, connection count, storage percentage

### Alert Thresholds
- **Critical**: CPU > 90%, Memory > 95%, Disk > 90%
- **Warning**: CPU > 75%, Memory > 80%, Disk > 75%
- **Response Time**: > 2 seconds (warning), > 5 seconds (critical)

## Troubleshooting

### Common Issues

**AKS Pods Not Starting**
- Check: Node capacity, image pull secrets, resource quotas
- Region: Must be in West Europe
- Solution: Scale node pool or check container registry access

**App Service Deployment Fails**
- Check: Region must be West Germany (germanywestcentral)
- Solution: Recreate in correct region if deployed elsewhere

**Database Connection Timeout**
- Check: Private endpoint configuration, NSG rules
- Solution: Verify VNet integration and firewall rules

## Support Contacts

- **AKS Issues**: ccoe-kubernetes@company.com
- **App Services**: ccoe-paas@company.com
- **Networking**: ccoe-network@company.com
- **Security**: ccoe-security@company.com

## Change Log

- **2026-02-08**: Initial documentation created
- **Region Constraints**: West Europe (AKS), West Germany (App Services)
