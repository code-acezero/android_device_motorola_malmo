#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# 1. Inherit Device Config FIRST
$(call inherit-product, device/motorola/malmo/device.mk)

# 2. Inherit Core Android (Required for booting)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# 3. Inherit TWRP Config LAST (The "Winner")
$(call inherit-product, vendor/twrp/config/common.mk)

# 4. Product Definition
PRODUCT_NAME := omni_malmo
PRODUCT_DEVICE := malmo
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g85 5G
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

# 5. Force TWRP Variant (Extra Safety)
RECOVERY_VARIANT := twrp

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="malmo_g-user 14 UUOS34HV-V1-ST11.1 1b15fc release-keys"

BUILD_FINGERPRINT := motorola/malmo_g/malmo:14/UUOS34HV-V1-ST11.1/1b15fc:user/release-keys
