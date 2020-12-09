################################################################################
#
# ti-img-sgx-km
#
# https://elinux.org/BeagleBoneBlack/SGX_%2B_Qt_EGLFS_%2B_Weston
#
################################################################################

TI_IMG_SGX_KM_VERSION = 2a777b8fb72a89d299b82845d42b63b2a2618daa
TI_IMG_SGX_KM_SITE = git://git.ti.com/graphics/omap5-sgx-ddk-linux.git
TI_IMG_SGX_KM_LICENSE = GPL-2.0
TI_IMG_SGX_KM_LICENSE_FILES = eurasia_km/GPL-COPYING

TI_IMG_SGX_KM_DEPENDENCIES = linux

TI_IMG_SGX_KM_MAKE_OPTS = \
	$(LINUX_MAKE_FLAGS) \
	KERNELDIR=$(LINUX_DIR) \
	TARGET_PRODUCT=$(TI_IMG_SGX_KM_PLATFORM_NAME)

ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM335X),y)
TI_IMG_SGX_KM_PLATFORM_NAME = ti335x
else ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM437X),y)
TI_IMG_SGX_KM_PLATFORM_NAME = ti437x
else ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM57XX),y)
TI_IMG_SGX_KM_PLATFORM_NAME = jacinto6evm
else ifeq ($(BR2_PACKAGE_TI_IMG_SGX_KM_AM654X),y)
TI_IMG_SGX_KM_PLATFORM_NAME = ti654x
endif

TI_IMG_SGX_KM_SUBDIR = eurasia_km/eurasiacon/build/linux2/omap_linux

define TI_IMG_SGX_KM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TI_IMG_SGX_KM_MAKE_OPTS) \
		-C $(@D)/$(TI_IMG_SGX_KM_SUBDIR)
endef

define TI_IMG_SGX_KM_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TI_IMG_SGX_KM_MAKE_OPTS) \
		DISCIMAGE=$(TARGET_DIR) \
		kbuild_install -C $(@D)/$(TI_IMG_SGX_KM_SUBDIR)
endef

$(eval $(generic-package))
