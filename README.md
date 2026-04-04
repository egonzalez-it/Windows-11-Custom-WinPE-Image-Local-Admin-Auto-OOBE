# Windows 11 Custom Image Deployment (WinPE + Auto OOBE)

## 📌 Overview
This project provides a modular and automated solution to deploy Windows 11 using:

- WinPE bootable ISO
- Custom captured image (`install.wim`)
- Deployment scripts
- `unattend.xml` for zero-touch setup

The goal is to enable **fast, consistent, and repeatable deployments** across systems.

---

## 🧠 Architecture

This project is structured into three main layers:

- **Build Layer** → Create image and ISO
- **Deployment Layer** → Execute installation in WinPE
- **Configuration Layer** → Automate Windows setup

---

## 📁 Project Structure

```text
Win11-Custom-Image-Auto-OOBE/
│
├── README.md
│
├── build/
│   ├── ISO-Creation.md
│   ├── Image-Capture.md
│
├── deployment/
│   ├── installmenu.bat
│   ├── startnet.cmd
│   ├── README.md
│
├── unattend/
│   ├── unattend.xml
│   ├── README.md
│
└── docs/
    ├── Deployment-Guide.md
    ├── Architecture.md
```
---

## 🚀 How It Works

```text
Build Image → Create ISO → Boot WinPE → Run Scripts → Apply Image → Unattend Config → Ready System
```

---

## 📚 Documentation

### 🔹 Build Process
- Image capture → `build/Image-Capture.md`
- ISO creation → `build/ISO-Creation.md`

### 🔹 Deployment
- Scripts behavior → `deployment/README.md`

### 🔹 Configuration
- Unattended setup → `unattend/README.md`

### 🔹 Usage Guide
- End-to-end usage → `docs/Deployment-Guide.md`

---

## ⚙️ Requirements

- Windows ADK
- WinPE Add-on
- Administrator privileges
- Reference Windows image

---

## ⚠️ Important Notes

- This process **erases the target disk**
- Assumes **Disk 0 is the internal drive**
- Not guaranteed in all hardware configurations
- Always test before production use

---

## 🧰 Technologies Used

- WinPE
- DISM
- Windows ADK
- Batch scripting
- Unattended Windows Setup

---

## 🎯 Use Cases

- IT provisioning
- Lab environments
- Standardized deployments
- Learning and testing imaging workflows

---

## 👤 Author

Eduardo González  
IT Technical Support / System Administration  
https://github.com/egonzalez-it

---

## 📄 License

MIT License
