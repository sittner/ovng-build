################################################################################
#
# ovngd
#
################################################################################

OVNGD_VERSION = b4a617f4b1c85e1a069acc2e4db1957370a60f98
OVNGD_SITE = https://github.com/sittner/ovngd.git
OVNGD_SITE_METHOD = git
OVNGD_LICENSE = GPL-2.0
OVNGD_LICENSE_FILES = COPYING

define OVNGD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" DESTDIR="$(TARGET_DIR)" -C $(@D) all
endef

define OVNGD_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

define OVNGD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(BR2_EXTERNAL_OVNG_PATH)/package/ovngd/S80ovngd $(TARGET_DIR)/etc/init.d/S80ovngd
endef

$(eval $(generic-package))
