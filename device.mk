#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/malmo

# ---------------------------------------------------------
# 1. CRITICAL: COPY FILES TO RAMDISK (The Missing Fix)
# ---------------------------------------------------------
# This section forces the Kernel and Init Scripts into the image.
# Without this, you get an empty generic recovery.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/kernel:kernel \
    $(LOCAL_PATH)/prebuilt/dtb:dtb \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:recovery/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/servicemanager.recovery.rc:recovery/root/servicemanager.recovery.rc

# Copy fstab if it exists in the standard location
# (If your fstab is in a different folder, adjust this path)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:recovery/root/system/etc/recovery.fstab

# ---------------------------------------------------------
# 2. A/B PARTITION CONFIGURATION
# ---------------------------------------------------------
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# ---------------------------------------------------------
# 3. BOOT CONTROL HAL (Safe Mode)
# ---------------------------------------------------------
# Using the generic Android Boot HAL prevents "Module not found" errors
# on minimal manifests.
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-impl.recovery

# Standard Update Tools
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    bootctrl.malmo

# ---------------------------------------------------------
# 4. QCOM TOOLS & LIBRARIES
# ---------------------------------------------------------
PRODUCT_PACKAGES += \
    libion \
    libxml2

# Allow TWRP to see the full screen
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    ro.boot.dynamic_partitions=true
