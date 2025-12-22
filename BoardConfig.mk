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
TARGET_BOARD_PLATFORM := holi

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := malmo
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 400

# Kernel - CRITICAL FOR ANDROID 14
# FIX: Specific video arguments to prevent black screen
BOARD_KERNEL_CMDLINE := console=video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1 firmware_class.path=/vendor/firmware_mnt/image pstore.compress=none loglevel=4 log_buf_len=256K mem.enable_mglru=1 nosoftlockup bootconfig

# FIX: Header version 4 (GKI)
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_PAGESIZE := 4096

# FIX: Manual Offsets (Safer than letting build system guess)
BOARD_KERNEL_BASE          := 0x00000000
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_KERNEL_SECOND_OFFSET := 0x00000000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_DTB_OFFSET           := 0x01f00000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Kernel - Prebuilt
# FIX: Ensure your file in the repo is named 'dtb.img'
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# ---------------------------------------------------------
# FIX: COMPRESSION & SIZE (The Magic Fixes)
# ---------------------------------------------------------
# 1. Use LZ4 to match Stock Moto format (Fixes "Bootloader Fallback")
BOARD_RAMDISK_USE_LZ4 := true

# Partitions
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728

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
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

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
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# TWRP Specifics
TW_THEME := portrait_hdpi
# FIX: Disable extra languages to save ~5MB (Prevents Size Error)
TW_EXTRA_LANGUAGES := false
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_CRYPTO := false
