################################################################################
#
# bborg-overlays
#
################################################################################

BBORG_OVERLAYS_VERSION = fe349743947df3dee4f6872e339b317b6c5bda50
BBORG_OVERLAYS_SITE = https://github.com/beagleboard/bb.org-overlays.git
BBORG_OVERLAYS_SITE_METHOD = git
BBORG_OVERLAYS_LICENSE = GPL-2.0
BBORG_OVERLAYS_LICENSE_FILES = debian/copyright
BBORG_OVERLAYS_DEPENDENCIES += host-dtc

define BBORG_OVERLAYS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CPP="$(TARGET_CPP)" CC="$(TARGET_CC)" DTC="dtc" DESTDIR="$(TARGET_DIR)" -C $(@D) all
endef

define BBORG_OVERLAYS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CPP="$(TARGET_CPP)" CC="$(TARGET_CC)" DTC="dtc" DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
