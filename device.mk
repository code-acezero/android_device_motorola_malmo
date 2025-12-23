#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/malmo

# ---------------------------------------------------------
# 1. COPY FILES (Cleaned Up)
# ---------------------------------------------------------
# Note: Kernel/DTB are handled by BoardConfig.mk now.
# We only copy the config scripts here.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:recovery/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/servicemanager.recovery.rc:recovery/root/servicemanager.recovery.rc

# Copy Fstab and Flags
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:recovery/root/system/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/system/etc/twrp.flags:recovery/root/system/etc/twrp.flags

# ---------------------------------------------------------
# 2. A/B CONFIGURATION
# ---------------------------------------------------------
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# ---------------------------------------------------------
# 3. BOOT CONTROL
# ---------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-impl.recovery \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    bootctrl.malmo

# ---------------------------------------------------------
# 4. LIBRARIES
# ---------------------------------------------------------
PRODUCT_PACKAGES += \
    libion \
    libxml2

PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    ro.boot.dynamic_partitions=true
