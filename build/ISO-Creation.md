# ISO Creation Guide (WinPE Custom Image)

## 📌 Overview
This guide explains how to create a **custom WinPE ISO** that includes:

- Your captured `install.wim`
- Deployment scripts (`startnet.cmd`, `installmenu.bat`)
- `unattend.xml` for automated setup

This ISO will be used to deploy Windows in a **fully automated and repeatable way**.

---

## 🧠 Workflow Summary

Prepare Files → Build WinPE → Inject Image & Scripts → Create ISO → Deploy (Burn to USB or booting tool like Ventoy)

---

## ⚙️ Prerequisites

### 1. Install Windows ADK

Download and install:

- **Deployment Tools**
https://go.microsoft.com/fwlink/?linkid=2289980

### 2. Install WinPE Add-on

- **Windows Preinstallation Environment (WinPE)**
https://go.microsoft.com/fwlink/?linkid=2289981

> ⚠️ Install both components before proceeding

---

## 📁 Recommended File Structure

Prepare your files before building the ISO:

C:\Files  
│  
├── WimFile\  
│   └── install.wim  
│  
└── Scripts\  
    ├── startnet.cmd  
    ├── installmenu.bat  
    └── unattend.xml  

---

## 🛠️ Build Process

### Step 1: Open Deployment Tools
Open **Deployment and Imaging Tools Environment** as Administrator.

---

### Step 2: Create WinPE Working Directory

```cmd
copype amd64 C:\WinPE_amd64
```

Creates a working directory with the base WinPE image.

---

### Step 3: Mount WinPE Image

```cmd
Dism /Mount-Image /ImageFile:C:\WinPE_amd64\media\sources\boot.wim /index:1 /MountDir:C:\WinPE_amd64\mount
```

Mounts the WinPE image so it can be modified.

---

### Step 4: Add Custom Image (install.wim)

```cmd
copy C:\Files\WimFile\*.* C:\WinPE_amd64\media\sources\
```

Copies your captured image into the ISO.

---

### Step 5: Add Deployment Scripts

```cmd
copy /y C:\Files\Scripts\*.* C:\WinPE_amd64\mount\Windows\System32\
```

Adds scripts that will run inside WinPE.

---

### Step 6: Commit and Unmount

```cmd
Dism /Unmount-Image /MountDir:C:\WinPE_amd64\mount /Commit
```

Saves all changes into the WinPE image.

---

### Step 7: Create the ISO

```cmd
MakeWinPEMedia /ISO C:\WinPE_amd64 C:\Windows_Gold_Image_Name.iso
```

Creates the bootable ISO file.

---

### Step 8: Clean Up

```cmd
rmdir /s /q C:\WinPE_amd64
```

Deletes the temporary working directory.

---

## 📦 Output

C:\Windows_Gold_Image_Name.iso

This ISO contains:
- WinPE environment
- install.wim (your custom image)
- Deployment scripts

---

## ⚠️ Important Notes

- Ensure `install.wim` exists before copying
- Verify scripts are tested before embedding
- Always run commands as Administrator
- Drive letters may differ when booting in WinPE

---

## 🚀 Best Practices

- Use clear ISO naming:
  - Windows11-23H2-Gold.iso
  - Windows11-Lenovo-E16.iso

- Keep scripts modular and reusable
- Test ISO in a VM before production use

---

## 🔄 Next Step

Boot from the ISO and begin deployment using your automated scripts.
