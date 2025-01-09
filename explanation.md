# Explanation.md

## 1. **Choice of Base Image**

### Web Application:
I selected `node:16-alpine` as the base image for the web application. This image was chosen because:
- It is lightweight and reduces the overall image size, ensuring the final image remains under 400MB.
- It includes all the necessary tools for running a Node.js application without unnecessary extras.
- The `alpine` variant is secure and has a smaller attack surface.

### MongoDB:
I used the official `mongo:5.0` image from DockerHub. This choice ensures compatibility with modern MongoDB features while providing a stable and secure environment.

---

## 2. **Dockerfile Directives**

The `Dockerfile` for the web application includes the following:

```Dockerfile
# Use a lightweight Node.js base image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port the application runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
```

### Explanation of Directives:
1. **FROM**: Specifies the base image.
2. **WORKDIR**: Sets the working directory for subsequent instructions.
3. **COPY**: Copies files from the host to the container.
4. **RUN**: Executes commands to install dependencies.
5. **EXPOSE**: Opens port 3000 for external access.
6. **CMD**: Defines the default command to start the application.

---

## 3. **Docker-Compose Networking**

The `docker-compose.yaml` file defines a custom bridge network called `app-network`. This allows the `web` and `mongo` containers to communicate seamlessly. Here is the relevant section:

```yaml
networks:
  app-network:
```

Each service is attached to this network to ensure proper communication. The web application can connect to the MongoDB service using the hostname `mongo` within the network.

---

## 4. **Volume Definition and Usage**

Volumes ensure data persistence for the MongoDB container, even if the container is restarted or rebuilt. The following configuration in `docker-compose.yaml` creates a named volume:

```yaml
volumes:
  mongo-data:
```

This volume is mounted to the MongoDB container:

```yaml
mongo:
  volumes:
    - mongo-data:/data/db
```

This setup ensures that product data added through the application remains intact.

---

## 5. **Git Workflow**

To ensure a structured development process, the following Git workflow was implemented:

1. **Initial Commit**: Forked and cloned the repository, followed by an initial commit.
   ```bash
   `git commit -m "Initial comit and Docker file created"`
   ```

2. **Step-by-Step Commits**: Each major change was committed with a descriptive message. Examples:
   - `git commit -m "Initial comit and Docker file created"`
   - `git commit -m "Add .dockerignore file"`

3. **Minimum 10 Commits**: To document the progression clearly, a minimum of 10 commits was maintained.

---

## 6. **Debugging Measures**

Several debugging techniques were employed during development:

- **Checking Logs**: Used `docker logs <container-id>` to troubleshoot container issues.
- **Rebuilding Containers**: Resolved build errors by running:
  ```bash
  docker-compose down
  docker-compose up --build
  ```
- **Testing Connectivity**: Verified network connectivity between containers using:
  ```bash
  docker exec -it <web-container-id> ping mongo
  ```

---

## 7. **Good Practices**

### Image Tagging:
- All images were tagged using semantic versioning (e.g., `web:1.0`, `mongo:5.0`).

### Naming Conventions:
- Containers and images were given descriptive names for easy identification.

### Lightweight Images:
- Chose minimal base images to reduce the total image size below 400MB.

---

## 8. **Screenshot of Deployed Image on DockerHub**

A screenshot is attached of my DockerHub repository showing:
- The `web` image with tag `1.0`.
- The `mongo` image with tag `5.0`.

---