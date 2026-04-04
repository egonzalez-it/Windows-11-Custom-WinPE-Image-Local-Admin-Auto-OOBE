# Deployment Guide

## 📌 Overview
This guide explains how to deploy Windows using the custom WinPE ISO created in this project.

It describes what happens after booting from the ISO and what the user should expect during the deployment process.

---

## 🖥️ Step 1: Boot from ISO

Boot the device using one of the following:

- USB (Rufus or similar)
- Ventoy
- Virtual Machine (ISO mounted)

Select the ISO as the boot device from BIOS/UEFI.

---

## ⚙️ Step 2: What Happens After Boot

Once the system boots:

- WinPE loads
- `startnet.cmd` runs automatically
- `installmenu.bat` launches

No manual steps are required to start the deployment.

---

## 🧭 Step 3: User Interaction

The user will see a simple menu:

[1] Full Automatic Mode  
[2] Manual Mode  
[3] Shutdown  

### Options:

- **Option 1 – Full Automatic Mode**
  - Starts the full deployment process

- **Option 2 – Manual Mode**
  - Opens a command prompt for troubleshooting and testing, you can manually test all steps included in the **installmenu.bat**

- **Option 3 – Shutdown**
  - Stops the process and powers off the device

---

## 💽 Step 4: Disk Behavior

The script:

- Targets **Disk 0**
- Assumes the internal disk is Disk 0
- Does not rely on drive letters (like C:)
- Uses a fixed letter (W:) for the Windows partition during deployment

### ⚠️ Important
Disk numbering depends on hardware and firmware.

This method is effective in standard environments with a single internal disk, but it is not guaranteed in all scenarios.

---

## 🚀 Step 5: Deployment Process

Once started, the process runs automatically:

Disk is cleaned  
→ Partitions are created  
→ Windows image is applied  
→ Bootloader is configured  
→ System reboots  

---

## 🔄 Step 6: After Reboot

After reboot:

- Windows starts
- OOBE is skipped
- Local accounts are created
- System is ready for use or further configuration

---

## ⚠️ Important Notes

- This process will erase all data on the target disk
- Always test in a lab before production use
- Ensure disk layout assumptions are valid for your hardware

---

## 📂 Related Components

- Deployment scripts → ../deployment/
- Unattended configuration → ../unattend/
- ISO build process → ../build/

---

## 👤 Author

Eduardo González  
IT Technical Support / System Administration  
https://github.com/egonzalez-it
