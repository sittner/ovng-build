################################################################################
#
# ovng-overlays
#
################################################################################

OVNG_OVERLAYS_VERSION = af3fbf21508f84f4f3839bda5cb047d02a5f7c25
OVNG_OVERLAYS_SITE = https://github.com/sittner/ovng-overlays.git
OVNG_OVERLAYS_SITE_METHOD = git
OVNG_OVERLAYS_LICENSE = GPL-2.0
OVNG_OVERLAYS_LICENSE_FILES = COPYING

OVNG_OVERLAYS_DEPENDENCIES += host-dtc ams5915 icm20948

define OVNG_OVERLAYS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CPP="$(TARGET_CPP)" -C $(@D) all
endef

define OVNG_OVERLAYS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
