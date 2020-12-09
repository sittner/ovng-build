################################################################################
#
# ti-img-sgx-um
#
# https://elinux.org/BeagleBoneBlack/SGX_%2B_Qt_EGLFS_%2B_Weston
#
################################################################################

TI_IMG_SGX_UM_VERSION = 7519eda203308c4356e68fd6af67a0900ed09cb4
TI_IMG_SGX_UM_SITE = http://git.ti.com/git/graphics/omap5-sgx-ddk-um-linux.git
TI_IMG_SGX_UM_SITE_METHOD = git
TI_IMG_SGX_UM_LICENSE = TI TSPA License
TI_IMG_SGX_UM_LICENSE_FILES = TI-Linux-Graphics-DDK-UM-Manifest.doc
TI_IMG_SGX_UM_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM335X),y)
TI_IMG_SGX_UM_TARGET = ti335x
else ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM437X),y)
TI_IMG_SGX_UM_TARGET = ti437x
else ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM57XX),y)
TI_IMG_SGX_UM_TARGET = jacinto6evm
else ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM654X),y)
TI_IMG_SGX_UM_TARGET = ti654x
endif

# ti-img-sgx-um is a egl/gles provider only if libdrm is installed
TI_IMG_SGX_UM_DEPENDENCIES = libdrm wayland libzlib

define TI_IMG_SGX_UM_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DISCIMAGE=$(STAGING_DIR) \
		TARGET_PRODUCT=$(TI_IMG_SGX_UM_TARGET) install
endef

define TI_IMG_SGX_UM_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DISCIMAGE=$(TARGET_DIR) \
		TARGET_PRODUCT=$(TI_IMG_SGX_UM_TARGET) install
endef

define TI_IMG_SGX_UM_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_OVNG_PATH)/package/ti-img-sgx-um/S80ti-img-sgx \
		$(TARGET_DIR)/etc/init.d/S80ti-img-sgx

endef

$(eval $(generic-package))
