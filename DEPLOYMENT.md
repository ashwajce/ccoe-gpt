# CCOEGPT Deployment Guide

## VS Code Development

### Prerequisites
- Rust toolchain installed
- VS Code with CodeLLDB extension
- Ollama running locally

### Setup
1. Open project in VS Code:
   ```bash
   cd /Users/ashwa/git/localgpt
   code .
   ```

2. Install recommended extension:
   - **CodeLLDB** (vadimcn.vscode-lldb) for Rust debugging

### Debugging
- Press `F5` or select "Debug CCOEGPT Daemon" from Run menu
- Set breakpoints by clicking left of line numbers
- Use Debug Console to inspect variables

### Build Tasks
Access via `Cmd+Shift+B` or Terminal > Run Task:
- **Build (Release)** - Production build
- **Run Daemon** - Start daemon
- **Stop Daemon** - Stop daemon
- **Run Tests** - Execute tests

---

## Kubernetes Deployment

### Prerequisites
- Kubernetes cluster access
- kubectl configured
- Container registry access (for image push)

### Build Container Image

Since you don't have Docker locally, build on your CI/CD or build server:

```bash
# On build server with Docker
docker build -t your-registry/ccoegpt:latest .
docker push your-registry/ccoegpt:latest
```

### Deploy to Kubernetes

1. **Update deployment.yaml**:
   - Replace `your-registry/ccoegpt:latest` with your actual image
   - Adjust resource limits as needed
   - Set storage class in `pvc.yaml` if required

2. **Apply manifests**:
   ```bash
   kubectl apply -f k8s/configmap.yaml
   kubectl apply -f k8s/pvc.yaml
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   ```

3. **Verify deployment**:
   ```bash
   kubectl get pods -l app=ccoegpt
   kubectl logs -f deployment/ccoegpt -c ccoegpt
   ```

4. **Download models** (exec into pod):
   ```bash
   kubectl exec -it deployment/ccoegpt -c ollama -- ollama pull llama3.2
   kubectl exec -it deployment/ccoegpt -c ollama -- ollama pull llama3.2:1b
   kubectl exec -it deployment/ccoegpt -c ollama -- ollama pull mistral:7b-instruct
   ```

5. **Access the UI**:
   ```bash
   # Port forward to local machine
   kubectl port-forward svc/ccoegpt 31327:31327
   
   # Open browser to http://localhost:31327
   ```

### Configuration

Edit ConfigMap to change settings:
```bash
kubectl edit configmap ccoegpt-config
kubectl rollout restart deployment/ccoegpt
```

### Troubleshooting

**Check pod status**:
```bash
kubectl describe pod -l app=ccoegpt
```

**View logs**:
```bash
# CCOEGPT logs
kubectl logs -f deployment/ccoegpt -c ccoegpt

# Ollama logs
kubectl logs -f deployment/ccoegpt -c ollama
```

**Exec into pod**:
```bash
kubectl exec -it deployment/ccoegpt -c ccoegpt -- /bin/bash
```

### Scaling

The deployment is set to 1 replica. To scale:
```bash
kubectl scale deployment/ccoegpt --replicas=2
```

Note: Multiple replicas will each have their own sessions. Consider using a shared storage solution for session persistence.

### Resource Requirements

**Minimum**:
- CCOEGPT: 512Mi RAM, 0.5 CPU
- Ollama: 2Gi RAM, 1 CPU

**Recommended**:
- CCOEGPT: 2Gi RAM, 2 CPU
- Ollama: 8Gi RAM, 4 CPU (or 1 GPU)

### Security

1. **Use private registry** for images
2. **Enable RBAC** for pod security
3. **Use secrets** for sensitive config
4. **Network policies** to restrict access
5. **Resource quotas** to prevent resource exhaustion
