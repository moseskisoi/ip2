## Explanation of Kubernetes Setup

### **Kubernetes Objects**

1. **Namespace**:
   - All resources are deployed in the `ecommerce` namespace for better organization and isolation.

2. **Deployments**:
   - **Webapp** is deployed as `Deployment` with 2 replicas each to ensure high availability.
   - Pods are labeled for easier management and tracking.

3. **StatefulSet**:
   - **MongoDB** is deployed as a `StatefulSet` to ensure persistent and stable storage across pod restarts.
   - Persistent storage is achieved using `PersistentVolumeClaims`.

4. **Services**:
   - **Webapp Service**: Exposed as a `LoadBalancer` for public access.
   - **MongoDB Service**: Exposed as `ClusterIP` services for internal communication.

5. **Persistent Volumes**:
   - MongoDB uses a persistent volume to ensure data durability. Even if the database pod is deleted, data remains intact.

### **Persistence**

- The MongoDB StatefulSet is configured with a `PersistentVolumeClaim` of 5Gi. This ensures that all products added to the cart remain persistent even if:
  - The MongoDB pod is restarted.
  - The cluster undergoes maintenance.

### **Git Workflow**

1. **Commit Messages**:
   - Descriptive commits are made at every step for clarity and tracking. 
     ```

2. **Repository Structure**:
   - The repository is well-structured:
     ```
     /kubernetes-manifests/
       - namespace.yaml
       - webapp-deployment.yaml
       - mongodb-statefulset.yaml
       - webapp-service.yaml
       - mongo-service.yaml
     README.md
     explanation.md
     ```

### **Orchestration and Best Practices**

- **StatefulSet for MongoDB**: Ensures stable storage and pod identity.
- **Load Balancer**: Exposes the frontend to external traffic.
- **Labels and Selectors**: Used extensively to organize and manage resources.
- **Semantic Versioning**: Docker images are tagged using semantic versioning (e.g., `v1.0.0`).
- **Namespace**: Isolates resources from other Kubernetes workloads.

### **Debugging**

- Use `kubectl logs` to check pod logs:
  ```bash
  kubectl logs <pod_name> -n ecommerce
  ```
- Use `kubectl describe` to inspect resources:
  ```bash
  kubectl describe pod <pod_name> -n ecommerce
  ```
- Check service status to ensure proper configuration:
  ```bash
  kubectl get services -n ecommerce
