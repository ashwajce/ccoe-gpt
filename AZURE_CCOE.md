# Azure CCOE Environment - Regional Constraints

## Supported Azure Regions

### Kubernetes (AKS)
- **Region**: West Europe
- **Note**: This is the ONLY supported region for AKS clusters in the CCOE environment

### App Services
- **Region**: West Germany  
- **Note**: This is the ONLY supported region for App Services in the CCOE environment

## Deployment Guidelines

When deploying CCOEGPT or any other services to the CCOE Azure environment:

1. **For Kubernetes deployments**: Always use **West Europe**
2. **For App Service deployments**: Always use **West Germany**

These are hard constraints enforced by the CCOE Azure environment configuration.
