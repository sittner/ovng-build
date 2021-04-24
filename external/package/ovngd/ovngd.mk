################################################################################
#
# ovngd
#
################################################################################

OVNGD_VERSION = 0de832c03b8e40bcd31eb2b6a408bcfd6abd5f04
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
