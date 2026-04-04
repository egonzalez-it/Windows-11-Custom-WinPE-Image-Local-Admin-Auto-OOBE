# ISO Build & Image Capture Guide (Enterprise-Level)

## 📌 Overview
This guide outlines the **enterprise-standard process** to build, generalize, and capture a Windows 11 golden image using Audit Mode, Sysprep, and DISM.

This image is intended for **scalable, repeatable, and production-ready deployments** using WinPE.

---

## 🧠 Enterprise Workflow

Install Windows → Audit Mode → Customize → Optimize → Sysprep → Capture → Validate → Deploy

---

## 🖥️ Step 1: Install Windows (Reference Device)

- Perform a clean Windows 11 installation
- Stop at **OOBE (Out-of-Box Experience)** screen

> ⚠️ Do NOT create users or complete setup

---

## ⚙️ Step 2: Enter Audit Mode

Press:

Ctrl + Shift + F3

System will:
- Reboot automatically
- Log in as built-in Administrator
- Enter Audit Mode

---

## 🛠️ Step 3: System Customization

### 🔹 Updates
- Install all Windows Updates
- Reboot until fully patched

### 🔹 Drivers
- Install OEM drivers (chipset, network, graphics)
- Validate in Device Manager

### 🔹 Applications
Install only **standardized enterprise apps**, such as:
- Microsoft 365
- Browsers
- Security tools
- VPN / corporate tools

### 🔹 Configuration
- Apply system settings (power, UI, policies if needed)
- Remove bloatware and unnecessary apps

---

## 🧹 Step 4: Image Optimization (Recommended)

- Run Disk Cleanup
- Clear temp files:
  - C:\Windows\Temp
  - C:\Users\Administrator\AppData\Local\Temp
- Optionally run:

dism /online /cleanup-image /startcomponentcleanup

---

## 🔁 Step 5: Run Sysprep (CRITICAL)

Sysprep prepares the system for cloning by removing unique identifiers.

### Command:

sysprep /oobe /generalize /shutdown

### Or GUI:
C:\Windows\System32\Sysprep\sysprep.exe

Options:
- Enter System Out-of-Box Experience (OOBE)
- ✔ Generalize
- Shutdown

---

## 🚨 IMPORTANT
- After Sysprep → **DO NOT boot back into Windows**
- Booting again will invalidate the image

---

## 💽 Step 6: Capture Image (WinPE)

Boot into WinPE and identify correct drive letters:

diskpart  
list volume  

### Capture command:

dism /capture-image /imagefile:C:\install.wim /capturedir:D:\ /name:"Win11-Enterprise-Gold" /compress:max /checkintegrity

---

## 📦 Output

install.wim → Production-ready image

---

## 🧪 Step 7: Validation (MANDATORY)

Before production:
- Deploy image to test device
- Validate:
  - OOBE behavior
  - Applications
  - Drivers
  - Performance
  - Domain/Intune readiness

---

## 🚀 Enterprise Best Practices

### 🔹 Versioning
Use consistent naming:

Win11-23H2-Gold-v1.wim  
Win11-23H2-Gold-v2.wim  

---

### 🔹 Change Management
Document:
- Installed apps
- Updates included
- Changes per version

---

### 🔹 Security
- Do NOT include:
  - User data
  - Cached credentials
  - Tokens

---

## 📚 Related Documentation

- Scripts → ../Scripts/README.md
- Unattend → ../Unattend/README.md
- ISO Build → ../ISO-Build/README.md

---

## 👤 Author

Eduardo González  
IT Technical Support / System Administration  
https://github.com/egonzalez-it
