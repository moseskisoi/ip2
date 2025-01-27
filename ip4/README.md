# README.md

## E-commerce Application Deployment on GKE

This repository contains the Kubernetes manifests and setup instructions for deploying an e-commerce web application on Google Kubernetes Engine (GKE). The application consists of three main components:

1. **Webapp** - A React.js-based UI. & A Node.js-based API.
3. **MongoDB** - A NoSQL database for data storage.

---

## Prerequisites

1. **Google Cloud Account**: Ensure you have a GCP account with billing enabled.
2. **Google Cloud SDK (gcloud)**: Installed and authenticated. Download [here](https://cloud.google.com/sdk/docs/install).
3. **Docker**: Installed and logged in to Docker Hub.
4. **kubectl**: Installed via the gcloud CLI.
5. **Git**: Installed and configured.

---

## Setup Instructions

### **1. Clone the Repository**
```bash
git clone <repository_url>
cd <repository_directory>
```

### **2. Build and Push Docker Images**

Navigate to the directories containing the Dockerfiles for each service and build the images:

**Webapp:**
```bash
docker build -t <dockerhub_username>/webapp:v1 .
docker push <dockerhub_username>/webapp:v1
```

**MongoDB uses the official image, so no custom build is needed.**

### **3. Create a GKE Cluster**
```bash
gcloud container clusters create ecommerce-cluster --num-nodes=3 --zone=<your_zone>
gcloud container clusters get-credentials ecommerce-cluster
```

### **4. Deploy the Application**

Apply the Kubernetes manifests:

```bash
kubectl apply -f kubernetes-manifests/namespace.yaml
kubectl apply -f kubernetes-manifests/mongodb-statefulset.yaml
kubectl apply -f kubernetes-manifests/mongo-service.yaml
kubectl apply -f kubernetes-manifests/webapp-deployment.yaml
kubectl apply -f kubernetes-manifests/webapp-service.yaml
```

### **5. Verify Resources**

Check the status of pods:
```bash
kubectl get pods -n ecommerce
```

Check the services:
```bash
kubectl get services -n ecommerce
```

### **6. Access the Application**

- Copy the **External IP** of the `webapp-service`:
  ```bash
  kubectl get service frontend-service -n ecommerce
  ```
- Open a browser and navigate to `http://<EXTERNAL_IP>`.

### **7. Test the Application**

1. Add a product using the form provided.
2. Verify that the product persists in the database even if the MongoDB pod is restarted.

---