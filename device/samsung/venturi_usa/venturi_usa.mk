# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
#DEVICE_PACKAGE_OVERLAYS := device/samsung/aries-common/overlay

$(call inherit-product, vendor/samsung/venturi_usa/venturi_usa-vendor.mk)
$(call inherit-product, build/target/product/full_base.mk)
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

DEVICE_PACKAGE_OVERLAYS := device/samsung/venturi_usa/overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/venturi_usa/overlay

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES += \
	device/samsung/venturi_usa/asound.conf:system/etc/asound.conf \
	device/samsung/venturi_usa/vold.fstab:system/etc/vold.fstab \
	device/samsung/venturi_usa/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg

PRODUCT_PACKAGES += \
    audio.primary.s5pc110 \
    libaudiohw_legacy \
    audio.a2dp.default \
    Torch \
    libaudioutils

# Init files
PRODUCT_COPY_FILES += \
	device/samsung/venturi_usa/init.smdkc110.rc:root/init.smdkc110.rc \
	device/samsung/venturi_usa/lpm.rc:root/lpm.rc \
	device/samsung/venturi_usa/ueventd.rc:root/ueventd.rc \
	device/samsung/venturi_usa/ueventd.smdkc110.rc:root/ueventd.smdkc110.rc

PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_PACKAGES += \
    Superuser \
    Trebuchet \
    su \

# Audio
PRODUCT_COPY_FILES += \
	device/samsung/venturi_usa/audio/liba2dp.so:system/lib/liba2dp.so \
	device/samsung/venturi_usa/audio/libasound.so:system/lib/libasound.so \
	device/samsung/venturi_usa/audio/libaudio.so:system/lib/libaudio.so \
	device/samsung/venturi_usa/audio/libaudiohw_op.so:system/lib/libaudiohw_op.so \
	device/samsung/venturi_usa/audio/libaudiohw_sf.so:system/lib/libaudiohw_sf.so \
	device/samsung/venturi_usa/audio/liblvvefs.so:system/lib/liblvvefs.so \
	device/samsung/venturi_usa/audio/lib_Samsung_Sound_Booster_Handphone.so:system/lib/lib_Samsung_Sound_Booster_Handphone.so \
	device/samsung/venturi_usa/audio/lib_Samsung_Resampler.so:system/lib/lib_Samsung_Resampler.so \
	device/samsung/venturi_usa/audio/libsamsungSoundbooster.so:system/lib/libsamsungSoundbooster.so \
	device/samsung/venturi_usa/audio/libsec-ril.so:system/lib/libsec-ril.so \
	device/samsung/venturi_usa/audio/libsecril-client.so:system/lib/libsecril-client.so

# Prebuilt kl keymaps
PRODUCT_COPY_FILES += \
	device/samsung/venturi_usa/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
	device/samsung/venturi_usa/cytma340_input.idc:system/usr/idc/cytma340_input.idc \
	device/samsung/venturi_usa/cytma340_input.kl:system/usr/keylayout/cytma340_input.kl

# Generated kcm keymaps
PRODUCT_PACKAGES := \
       cypress-touchkey.kcm \
       s3c-keypad.kcm

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	device/samsung/venturi_usa/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# These are the OpenMAX IL modules
#PRODUCT_PACKAGES += \
#	libSEC_OMX_Core.aries \
#	libOMX.SEC.AVC.Decoder.aries \
#	libOMX.SEC.M4V.Decoder.aries \
#	libOMX.SEC.M4V.Encoder.aries \
#	libOMX.SEC.AVC.Encoder.aries

# Misc other modules
#PRODUCT_PACKAGES += \
#	lights.aries \
#	overlay.aries \
#	sensors.aries

# Libs
PRODUCT_PACKAGES += \
        audio.primary.s5pc110 \
	libcamera \
	libstagefrighthw

# apns config file
#PRODUCT_COPY_FILES += \
#        vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Bluetooth MAC Address
PRODUCT_PACKAGES += \
	bdaddr_read

# Device-specific packages
PRODUCT_PACKAGES += \
	SamsungServiceMode \

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
        frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
       wifi.interface=eth0 \
       wifi.supplicant_scan_interval=15 \
       dalvik.vm.heapsize=72m

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
        ro.com.google.locationfeatures=1 \
        ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs 
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false \
    persist.sys.vold.switchexternal=1

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# kernel modules for ramdisk
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/samsung/venturi_usa/modules/ramdisk,root/lib/modules)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/samsung/venturi_usa/modules/ramdisk,recovery/root/lib/modules)

# kernel modules
PRODUCT_COPY_FILES += $(foreach module,\
	$(wildcard device/samsung/venturi_usa/modules/*.ko),\
	$(module):system/lib/modules/$(notdir $(module)))

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/samsung/venturi_usa/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/venturi_usa/venturi_usa-vendor.mk)
