# Architecture Overview

## 📌 Purpose
This document explains **how the components of this project work together** during deployment.

It is not a step-by-step guide.  
It is a **high-level view of the system design**.

---

## 🧠 Why This Exists

When looking at the project, you may see multiple parts:

- WinPE ISO
- Deployment scripts
- Unattend.xml
- Captured image (WIM)

This file answers:

> “How do all these pieces connect during deployment?”

---

## 🔄 End-to-End Flow

```text
1. Build Phase
   - Capture Windows image (install.wim)
   - Create WinPE ISO with scripts

2. Boot Phase
   - Device boots from ISO
   - WinPE loads

3. Deployment Phase
   - startnet.cmd runs
   - installmenu.bat executes
   - Disk is prepared
   - install.wim is applied

4. Configuration Phase
   - System reboots
   - unattend.xml runs
   - OOBE is skipped
   - Local accounts and settings applied

5. Final State
   - Windows is ready for use
```

---

## 🧩 Components and Roles

### WinPE ISO
- Boot environment
- Contains scripts and image

### install.wim
- The Windows image being deployed

### startnet.cmd
- Starts the deployment process automatically

### installmenu.bat
- Controls disk setup and image deployment

### unattend.xml
- Automates Windows setup after reboot

---

## 🎯 Summary

This project is built as a simple pipeline:

```text
Build → Boot → Deploy → Configure → Ready
```

Each component has a clear responsibility and works together to create a fully automated deployment.

---

## 👤 Author

Eduardo González  
