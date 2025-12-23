#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/malmo

# A/B Configuration
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
# Use the Qualcomm specific boot control for better compatibility
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# Boot Control Tools
PRODUCT_PACKAGES += \
    bootctrl.holi \
    bootctrl.holi.recovery

# FIX: Removed 'bootctrl.blair'. We don't have the source code for it.
# PRODUCT_PACKAGES += \
#     bootctrl.blair

# FIX: Point static boot control to the generic library (libbootcontrol) or remove.
# For TWRP 12.1, usually 'bootctrl.hollywood' or generic 'bootctrl' is used for Qualcomm.
# Let's try removing the static definition to let TWRP auto-select.
# PRODUCT_STATIC_BOOT_CONTROL_HAL := \
#     bootctrl.blair \
#     libgptutils \
#     libz \
#     libcutils

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload
