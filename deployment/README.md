# Deployment Scripts Guide (WinPE)

## 📌 Overview
This section explains how the deployment process is controlled inside the custom WinPE ISO using two key scripts:

- `startnet.cmd`
- `installmenu.bat`

These scripts work together to provide a simple and repeatable deployment experience when the ISO boots.

---

## 🧠 How It Works

Boot ISO → WinPE loads → startnet.cmd runs → installmenu.bat launches → Deployment begins

---

## ⚙️ startnet.cmd

### Purpose
This script runs automatically when WinPE starts.

### What it does
- Initializes the WinPE environment
- Prepares the system for deployment
- Launches the main deployment script (`installmenu.bat`)

### Key Role
Acts as the entry point of the deployment process.

---

## ⚙️ installmenu.bat

### Purpose
This is the main deployment script executed after WinPE starts.

### What it does
- Starts the deployment workflow
- Prepares the target disk
- Applies the Windows image (`install.wim`)
- Triggers Windows setup

### Key Role
Acts as the deployment engine.

---

## 💽 Disk Targeting Behavior

This version of the script is designed to target **Disk 0**:

- The script selects Disk 0 as the installation target
- It does not rely on drive letters such as C: (which may change in WinPE)
- The Windows partition is assigned a fixed drive letter (W:) during deployment for consistency

---

## ⚠️ Important Limitation

This approach assumes:

- The device has a single internal disk
- The internal disk is enumerated as Disk 0
- The bootable USB (or Ventoy device) is not Disk 0

These assumptions are common in standard environments, but not guaranteed.

---

## 🔒 Boot Media Handling

The script:
- Detects the installation media by locating sources\install.wim
- Reassign the boot media to another drive letter (for consistency)

---

## 🖥️ What the User Sees

When the device boots from the ISO:

1. WinPE loads
2. The deployment process starts automatically
3. The user may see:
   - A command prompt window
   - A deployment menu (depending on script behavior)
   - Or a mostly automated process

Typical flow:
- Disk 0 is selected
- Disk is partitioned and formatted
- Image is applied
- System reboots into Windows setup
- unattend.xml completes configuration
- script bypass OOBE and autologin local admin account

---

## ⚠️ Deployment Safety Notice

This script is considered:

- Safe for controlled environments
- Suitable for standardized hardware (single internal disk)
- Not fully safe for unknown or mixed hardware configurations

### Examples of risk scenarios:
- USB device enumerated as Disk 0
- Systems with multiple internal disks
- Virtual machines with different disk ordering
- BIOS/UEFI variations

---

## 👤 Author

Eduardo González  
IT Technical Support / System Administration  
https://github.com/egonzalez-it
