# Unattend.xml Configuration Guide

## 📌 Overview
This `unattend.xml` file automates the Windows 11 installation and Out-of-Box Experience (OOBE), enabling a **zero-touch deployment** when used with your custom WinPE imaging process.

It ensures that once the image is applied, Windows setup completes automatically without requiring manual user input.

---

## 🧠 What This File Does

The unattend.xml file:

- Automates Windows setup phases
- Skips unnecessary OOBE screens
- Configures system settings
- Creates initial users configuration
- Prepares the device for immediate use or further management (Intune / domain)

---

## ⚙️ Main Configuration Areas

### 🔹 OOBE Automation
- Skips privacy settings screens
- Skips region and keyboard prompts
- Bypasses Microsoft account requirement
- Enables a faster first boot experience

---

### 🔹 User Account Setup
- Creates a local administrator account 'ladmin'
- Creates a local standard user account 'localuser'
- Sets passwords to never expires
- Avoids manual user creation during setup

> ✅ This is why no user needs to be created during image preparation

---

### 🔹 System Configuration
- Sets system locale, language, and region
- Configures time zone
- Applies basic Windows settings

---

## ⚠️ Important Notes

- Must be placed in the correct location during deployment:
  - Typically: C:\Windows\Panther\unattend.xml or injected via deployment process
- Incorrect configuration can break setup
- Always test after modifying

---

## 🚀 Best Practices

- Keep the file minimal and clean
- Do not hardcode sensitive information (passwords in plain text)
- Use it together with:
  - WinPE deployment scripts
  - Standardized images

---

## 🎯 Summary

The `unattend.xml` file is the **key component enabling full automation** of your deployment process.  

Without it:
- Users must manually complete setup  

With it:
- Deployment becomes fast, consistent, and scalable

---

## 👤 Author

Eduardo González  
IT Technical Support / System Administration  
https://github.com/egonzalez-it
