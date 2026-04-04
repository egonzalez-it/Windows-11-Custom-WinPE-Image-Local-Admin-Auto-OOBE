@echo off
setlocal enabledelayedexpansion

:: === MODE SELECTION LOOP ===
:select_mode
cls
echo =========================================
echo  WINDOWS INSTALLATION MODE SELECTION
echo =========================================
echo.
echo  [1] Full Automatic Mode
echo  [2] Manual Mode (drop to CMD)
echo  [3] Shutdown and Abort
echo.
set /p userChoice=Choose mode (1, 2 or 3): 

if "%userChoice%"=="1" (
    echo.
    echo Automatic mode selected. Continuing...
    goto :start
) else if "%userChoice%"=="2" (
    echo.
    echo Manual mode selected. Dropping to command prompt...
    cmd
    exit /b
) else if "%userChoice%"=="3" (
    echo.
    echo Aborting installation. System will shut down now.
    wpeutil shutdown
    exit /b
) else (
    echo.
    echo Invalid selection. Please enter 1, 2, or 3.
    timeout /t 2 >nul
    goto :select_mode
)

:: === MAIN SCRIPT START ===
:start
cls
echo === Volume List ===
echo list volume > X:\listvol.txt
diskpart /s X:\listvol.txt > X:\volumes.txt
type X:\volumes.txt
echo.  
echo STEP 0: Detecting USB/DVD boot media...
set "BootMedia="
for %%L in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%L:\sources\install.wim" (
        echo Found boot media at %%L:
        echo select volume %%L > X:\assignusb.txt
        echo assign letter=U >> X:\assignusb.txt
        diskpart /s X:\assignusb.txt >nul
        del X:\assignusb.txt
        set "BootMedia=U:"
        goto :usb_done
    )
)
echo ERROR: Could not find install.wim on any connected drive.

exit /b 1

:usb_done
echo Boot media reassigned to: %BootMedia%
echo. 
echo === Volume List ===
echo list volume > X:\listvol.txt
diskpart /s X:\listvol.txt > X:\volumes.txt
type X:\volumes.txt
echo.  


:: STEP 1: Identify available disks; abort if only one is present
cls
echo STEP 1: Listing all disks and volumes...
echo list disk > X:\listdisk.txt
diskpart /s X:\listdisk.txt > X:\disks.txt

set DISKCOUNT=0
for /f "skip=8 tokens=1" %%A in (X:\disks.txt) do (
    if /i "%%A"=="Disk" set /a DISKCOUNT+=1
)
echo Number of disks detected: %DISKCOUNT%
echo. 

if %DISKCOUNT% LSS 2 (
    echo ***************************************************************
    echo * ERROR: Only one disk was detected in the system.            *
    echo * No suitable target disk for installation was found!         *
    echo * Connect an internal HDD/SSD and try again.                  *
    echo * Dropping to command prompt for troubleshooting...           *
    echo ***************************************************************
    pause
    cmd
    exit /b 2
)

echo === Disk List ===
type X:\disks.txt

echo "Disk 0 selected as a target"


:: Extract the drive letter of boot media
set "BootVolumeLetter=%BootMedia:~0,1%"
set "BootDisk="

for /f "skip=8 tokens=2,3,4,*" %%A in (X:\volumes.txt) do (
    echo %%B | find /I "%BootVolumeLetter%" >nul && set "BootDisk=%%C"
)

echo Boot media is located on disk: %BootDisk%

:: Select the first available Online disk that is not the boot disk
set "HDDIndex="
for /f "skip=8 tokens=2,3" %%A in (X:\disks.txt) do (
    if "%%B"=="Online" (
        if not "%%A"=="%BootDisk%" if not defined HDDIndex set "HDDIndex=%%A"
    )
)

if not defined HDDIndex (
    echo ERROR: No valid target disk found. Aborting.
    pause
    exit /b 3
)
echo Selected target disk index: %HDDIndex%
echo. 
echo. 

:: STEP 2: Create DiskPart partitioning script
echo STEP 2: Creating partition script for disk %HDDIndex%...
set PARTTXT=X:\partition_auto.txt
(
    echo select disk %HDDIndex%
    echo clean
    echo convert gpt
    echo create partition efi size=100
    echo format quick fs=fat32 label="System"
    echo assign letter=S
    echo create partition msr size=16
    echo create partition primary
    echo shrink minimum=1024
    echo format quick fs=ntfs label="Windows"
    echo assign letter=W
    echo create partition primary
    echo format quick fs=ntfs label="Recovery"
    echo assign letter=R
    echo set id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
    echo gpt attributes=0x8000000000000001
) > %PARTTXT%

echo === Partition Script ===
type %PARTTXT%

:: STEP 3: Partition the target disk
cls
echo STEP 3: Partitioning disk %HDDIndex%...
diskpart /s %PARTTXT%
if errorlevel 1 (
    echo ERROR: Partitioning failed.
    pause
    exit /b 4
)
echo Disk partitioned successfully.


:: STEP 4: Detect Windows partition
cls
echo STEP 4: Detecting volume labeled "Windows"...
set "TargetDrive="
for %%G in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    vol %%G: 2>nul | find /I "Windows" >nul && (set "TargetDrive=%%G:" & goto found_target)
)
:found_target
if not defined TargetDrive (
    echo ERROR: Could not detect target volume labeled "Windows".
    pause
    exit /b 5
)

echo === Volume List ===
echo list volume > X:\listvol.txt
diskpart /s X:\listvol.txt > X:\volumes.txt
type X:\volumes.txt
echo. 
echo Target partition found at: %TargetDrive%


:: STEP 5: Apply Windows image
echo "STEP 5: Apply Windows image "

echo STEP 5: Applying Windows image to %TargetDrive%...
dism /Apply-Image /ImageFile:%BootMedia%\sources\install.wim /Index:1 /ApplyDir:%TargetDrive%\
echo Image applied successfully.


:: STEP 6: Configure Bootloader
echo STEP 6: Configuring bootloader...
echo. 
echo === Volume List ===
echo list volume > X:\listvol.txt
diskpart /s X:\listvol.txt > X:\volumes.txt
type X:\volumes.txt


%TargetDrive%\Windows\System32\bcdboot %TargetDrive%\Windows /s S: /f UEFI
echo Bootloader configured successfully.


:: STEP 7: Copy unattend.xml if exists

echo STEP 7: Checking for unattend.xml...
if exist X:\Windows\System32\unattend.xml (
    mkdir %TargetDrive%\Windows\Panther\Unattend 2>nul
    copy X:\Windows\System32\unattend.xml %TargetDrive%\Windows\Panther\Unattend\unattend.xml >nul
    echo unattend.xml copied successfully.
) else (
    echo No unattend.xml found. Skipping.
)


:: FINAL STEP
cls
echo ==================================================================
echo === Installation complete!                                     ===
echo === Remove bootable media or change boot order while rebooting ===
echo === Press any key to reboot                                    ===
echo ==================================================================

wpeutil reboot