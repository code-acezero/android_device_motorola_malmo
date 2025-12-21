#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/malmo

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Platform
# FIX: 'blair' is the Moto codename, but the SoC platform is 'holi' (Snapdragon 695/6s Gen 3).
# We use 'holi' to ensure TWRP finds the right dependencies.
TARGET_BOARD_PLATFORM := holi

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := malmo
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 400

# Kernel - CRITICAL FOR ANDROID 14
# FIX: Header version 4 means this device uses Generic Kernel Image (GKI).
# The recovery ramdisk lives in vendor_boot, not boot.
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Kernel - Prebuilt
# FIX: Ensure you actually have a file named 'Image' or 'Image.gz' in your /prebuilt/kernel folder!
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
endif

# ----------------------------------------
# FIX: ADD THESE LINES FOR THE DTB ERROR
# ----------------------------------------
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt
BOARD_DTB_OFFSET := 0
# ----------------------------------------


# Partitions
# FIX: Defined vendor_boot size. This is required for GKI devices.
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728

# FIX: Removed RECOVERYIMAGE_PARTITION_SIZE because this device does not have a dedicated recovery partition.
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728 

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 9122611200

# A/B Configuration
AB_OTA_UPDATER := true
# FIX: Added vendor_boot and dtbo to the A/B list. Essential for updates.
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    product \
    vendor \
    system_ext \
    vendor_boot \
    vbmeta \
    vbmeta_system

# Recovery Configuration
# FIX: This is the most important change.
# For Header V4, we do NOT use RECOVERY_AS_BOOT. We move resources to vendor_boot.
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
# BOARD_USES_RECOVERY_AS_BOOT := true  <-- DEPRECATED for GKI

TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2025-12-31
PLATFORM_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 14

# AVB (Verified Boot)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# TWRP Specifics
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true

# Encryption - TEMPORARILY DISABLED
# Fix: Disable encryption for the first build to ensure it boots. 
# Once it boots, we can try to enable decryption later.
TW_INCLUDE_CRYPTO := false
