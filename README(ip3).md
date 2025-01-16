# **E-Commerce Application Deployment with Ansible and Terraform**

This project automates the deployment and orchestration of a containerized e-commerce web application using Ansible and Terraform. The application includes a frontend, backend, and MongoDB database, demonstrating modern DevOps practices such as configuration management, containerization, and infrastructure as code.

---

## **Project Objectives**

1. **Automate Configuration Management**:
   - Use Ansible to configure and deploy all necessary components.
2. **Containerize the Application**:
   - Utilize Docker for the frontend, backend, and MongoDB services.
3. **Infrastructure as Code**:
   - Use Terraform for provisioning resources and invoking Ansible for server configuration.
4. **Service Orchestration**:
   - Ensure all components interact seamlessly using Docker Compose.

---

## **Features**

- Fully containerized e-commerce application with persistent data storage.
- Automated deployment using Ansible.
- Infrastructure provisioning using Terraform (Stage 2).
- Custom Ansible roles for modular task management.
- Clear separation of configuration files, roles, and variables for maintainability.

---

## **Project Structure**

```
├── ansible/
│   ├── inventory/
│   │   └── hosts
│   ├── roles/
│   │   ├── docker-setup/
│   │   │   ├── tasks/
│   │   │   │   └── main.yml
│   │   ├── mongo-setup/
│   │   │   ├── tasks/
│   │   │   │   └── main.yml
│   │   └── web-app-setup/
│   │       ├── tasks/
│   │       │   └── main.yml
│   ├── playbook.yml
├── terraform/
│   ├── main.tf
├── Dockerfile 
├── docker-compose.debug.yml
├── Vagrantfile
├── README.md
├── explanation.md
└── .gitignore
```

---

## **Prerequisites**

1. **Install Dependencies**:
   - [Vagrant](https://www.vagrantup.com/)
   - [Ansible](https://www.ansible.com/)
   - [Terraform](https://www.terraform.io/)
   - [Docker](https://www.docker.com/)

2. **Verify Installations**:
   Run the following commands to ensure dependencies are installed:
   ```bash
   vagrant --version
   ansible --version
   terraform --version
   docker --version
   ```

---

## **Setup Instructions**

### **Stage 1: Ansible Instrumentation**

1. **Provision a Virtual Machine**:
   - Clone the repository and navigate to the project directory.
   - Run `vagrant up` to provision a VM using the `Vagrantfile`.

2. **Configure the VM Using Ansible**:
   - Edit the `ansible/inventory/hosts` file to include the VM IP and credentials.
   - Use the Ansible playbook to configure and deploy the application:
     ```bash
     ansible-playbook -i ansible/inventory/hosts ansible/playbook.yml
     ```

3. **Test the Application**:
   - Access the application in your browser at `http://192.168.56.10:3000`.

---

### **Stage 2: Terraform and Ansible Integration**

1. **Provision Resources with Terraform**:
   - Navigate to the `terraform/` directory and initialize Terraform:
     ```bash
     terraform init
     ```
   - Create the infrastructure:
     ```bash
     terraform apply
     ```

2. **Deploy with Ansible**:
   - Terraform automatically triggers Ansible to configure the resources and deploy the application.

3. **Verify Deployment**:
   - Access the application in your browser using the IP provided in the Terraform output.

---

## **Key Files and Directories**

1. **`ansible/playbook.yml`**:
   - Defines tasks for setting up the Docker containers.

2. **`ansible/roles/`**:
   - Contains modular roles for frontend, backend, and database configurations.

3. **`terraform/`**:
   - Holds Terraform configuration files for provisioning the environment.

4. **`docker-compose.debug.yml`**:
   - Debug version of the Docker Compose file for local testing.

5. **`.dockerignore`**:
   - Specifies files and directories to exclude from Docker builds.

6. **`explanation.md`**:
   - Provides a detailed explanation of the project setup and workflow.

---

## **Git Workflow**

- Descriptive commits for every step:
  - `git add .`
  - `git commit -m "Added Ansible playbook for backend configuration"`
- Maintain a clean commit history with meaningful messages.

---

## **Testing and Debugging**

1. **Connectivity**:
   - Test Ansible connectivity:
     ```bash
     ansible -i ansible/inventory/hosts all -m ping
     ```

2. **Application Logs**:
   - View logs for debugging:
     ```bash
     docker logs <container_id>
     ```

3. **Validate Terraform Configuration**:
   - Run:
     ```bash
     terraform validate
     ```

---

## **Good Practices**

1. **Variable Management**:
   - Use `defaults/main.yml` for default values.
   - Use `terraform/variables.tf` for resource configuration.

2. **Descriptive Tags**:
   - Apply tags in playbooks for easier task targeting:
     ```yaml
     - name: Install dependencies
       tags: dependencies
     ```

3. **Resource Cleanup**:
   - Destroy Terraform-provisioned resources when done:
     ```bash
     terraform destroy
     ```

---

