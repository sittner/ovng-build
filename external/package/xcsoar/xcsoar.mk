################################################################################
#
# xcsoar
#
################################################################################

XCSOAR_VERSION = v6.8.17-ovng1
XCSOAR_SITE = https://github.com/sittner/XCSoar.git
XCSOAR_SITE_METHOD = git
XCSOAR_LICENSE = GPL-2.0
XCSOAR_LICENSE_FILES = COPYING
XCSOAR_DEPENDENCIES += zlib freetype libpng jpeg openssl libcurl librsvg imagemagick gettext dejavu boost sdl2

XCSOAR_MAKE = $(TARGET_MAKE_ENV) $(MAKE) \
	TARGET=UNIX \
	ENABLE_SDL=y \
	USE_SDL2=y \
	USE_SDL2_BATTERY=n \
	OPENGL=n \
	FIXED_DATADIR=/xcsdata \
	DESTDIR=$(TARGET_DIR) \
	TCPREFIX=$(TARGET_CROSS) \
	HOST_IS_ARM=$(BR2_ARM_CPU_HAS_ARM) \
	HOST_IS_PI=$(BR2_PACKAGE_RPI_USERLAND) \
	HOST_IS_ARMV6=$(BR2_ARM_CPU_ARMV6) \
	HOST_IS_ARMV7=$(BR2_ARM_CPU_ARMV7A) \
	HOST_HAS_NEON=$(BR2_ARM_CPU_HAS_NEON) \
	HOST_HAS_MALI=$(BR2_PACKAGE_SUNXI_MALI)$(BR2_PACKAGE_SUNXI_MALI_MAINLINE) \
	DEBUG=n \

define XCSOAR_BUILD_CMDS
	$(XCSOAR_MAKE) -C $(@D) all
endef

define XCSOAR_INSTALL_TARGET_CMDS
	$(XCSOAR_MAKE) -C $(@D) install-bin install-mo
endef

define XCSOAR_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(BR2_EXTERNAL_OVNG_PATH)/package/xcsoar/S90xcsoar $(TARGET_DIR)/etc/init.d/S90xcsoar
endef

$(eval $(generic-package))

