# Android device tree for motorola moto g85 5G (malmo)

```
#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
#
#
#
#
#
#
#
#
===================================================================
   TWRP BUILD GUIDE FOR MOTO G85 (Code: malmo) - LINUX PC / WSL2
===================================================================

DISCLAIMER: 
This process involves modifying system partitions. Always backup your data.
For Moto G85 (Android 14), we are building a "Vendor Boot" image because 
it uses GKI (Generic Kernel Image) and Virtual A/B partitions.

-------------------------------------------------------------------
PHASE 1: SYSTEM PREPARATION
-------------------------------------------------------------------
1. Open your Linux Terminal (Ubuntu 20.04 or 22.04 recommended).

2. Install the required tools and libraries:
   sudo apt update
   sudo apt install git-core gnupg flex bison build-essential zip curl \
   zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 \
   lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev \
   libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig python3 \
   python3-pip cpio

3. Setup the "Repo" tool (Google's Git manager):
   mkdir -p ~/bin
   curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
   chmod a+x ~/bin/repo
   export PATH=~/bin:$PATH

4. Configure Git Identity (Required to sync code):
   git config --global user.email "your_email@example.com"
   git config --global user.name "Your Name"

-------------------------------------------------------------------
PHASE 2: DOWNLOADING SOURCE CODE
-------------------------------------------------------------------
1. Create a working directory:
   mkdir ~/twrp_g85
   cd ~/twrp_g85

2. Initialize the TWRP 12.1 Repo (Best for Android 12/13/14):
   repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

3. Download the code (This downloads ~20GB, takes time):
   repo sync -j$(nproc --all)

-------------------------------------------------------------------
PHASE 3: SETTING UP YOUR DEVICE TREE
-------------------------------------------------------------------
1. Clone your device tree into the correct folder path:
   git clone https://github.com/code-acezero/android_device_motorola_malmo device/motorola/malmo

2. Verify the Kernel presence:
   * Navigate to the folder: cd device/motorola/malmo/prebuilt
   * Ensure your kernel file is named exactly 'kernel' (no extension).
   * If it's missing, copy the 'kernel' file (extracted from stock boot.img) here now.

3. Verify BoardConfig.mk (Important Check):
   * Open device/motorola/malmo/BoardConfig.mk
   * Ensure this line matches your kernel filename:
     TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
   * Ensure this partition setting is present (for Android 14):
     BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

-------------------------------------------------------------------
PHASE 4: BUILDING
-------------------------------------------------------------------
1. Go back to the root folder:
   cd ~/twrp_g85

2. Set up the build environment:
   . build/envsetup.sh

3. Select your device (Lunch):
   lunch twrp_malmo-eng

4. Start the compilation (Build Vendor Boot):
   mka vendorbootimage

   (Note: Do NOT use 'mka recoveryimage' for this device. It will fail.)

-------------------------------------------------------------------
PHASE 5: OUTPUT & TESTING
-------------------------------------------------------------------
1. Locate your file:
   Once the build says "Success", go to:
   out/target/product/malmo/vendor_boot.img

2. Copy this file to your Windows PC (if using WSL) or phone.

3. BOOT TEST (Safe Mode):
   * Put phone in Fastboot mode (Vol Down + Power).
   * Connect to PC.
   * Run:
     fastboot boot vendor_boot.img

   * IF IT BOOTS: Great! Check touchscreen and storage access.
   * IF IT BOOTLOOPS: Hold Power + Vol Down to force restart to bootloader. 
     You are safe because you didn't flash it permanently.

-------------------------------------------------------------------
TROUBLESHOOTING COMMON ERRORS
-------------------------------------------------------------------
* Error: "No rule to make target..."
  Fix: Your device tree folder is likely in the wrong path. 
  It MUST be in: ~/twrp_g85/device/motorola/malmo

* Error: "ninja: build stopped: subcommand failed"
  Fix: Scroll up to find the red error text. 
  Usually means a missing dependency or typo in BoardConfig.mk.
```
