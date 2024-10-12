# **Inventory Management System**

An advanced and scalable **Inventory Management System** built for tracking components, projects, orders, and managing YouTube video details. This app integrates with MinIO for file storage and provides seamless integration with GitHub for tracking commits. It is designed for use in home labs and hobby projects.

## 🚀 **Features**

- 📦 **Component Management**: Track components with quantity, cost, and detailed metadata.
- 🗂️ **Storage Management**: Assign components to specific storage containers and generate QR codes for quick access.
- 📋 **Project Tracking**: Monitor project components usage, including dynamic updates to quantities and project details. Also integrated with GitHUB, to check project specific commits.
- 🎬 **YouTube Video Management**: Manage YouTube projects, including script writing, video status tracking, and video metadata.
- 📂 **Order Management**: Keep records of orders, including vendor information, costs, and detailed breakdowns of the parts.
- ☁️ **MinIO Integration**: Store component-related files, invoices, and project files in MinIO.
- 🔄 **GitHub Integration**: Track commits related to the app's development.

## 🛠️ **Tech Stack**

- **Backend**: PostgreSQL (Database)
- **Frontend**: AppSmith (UI & Business Logic)
- **File Storage**: MinIO (S3 Compatible)
- **Git Integration**: GitHub
- **Libraries**:
  - `qrcode-generator` (v1.4.4): For generating QR codes for containers.
  - `jsPDF` (v2.5.2): For generating dynamic PDFs for labels and reports.

## 📖 **Getting Started**

### 1. **Clone the Repository**

```bash
git clone https://github.com/WGLabz/InventoryApp-ApSmith-.git
cd InventoryApp-ApSmith-
```
### 2. ** Spin up the stack**

```bash
docker-compose up -d
```
### 3. **Setup MongoDB replication**

> login to the monoDB container and run the following command,

```js
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongo1:27017" }
  ]
})

```
