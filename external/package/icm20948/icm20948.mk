################################################################################
#
# icm20948
#
################################################################################

ICM20948_VERSION = c3ea032790cb4007789044467ee91e20e0a05f78
ICM20948_SITE = https://github.com/sittner/icm20948-mod.git
ICM20948_SITE_METHOD = git
ICM20948_LICENSE = GPL-2.0
ICM20948_LICENSE_FILES = COPYING

ICM20948_MODULE_MAKE_OPTS = CONFIG_ICM20948=m

$(eval $(kernel-module))
$(eval $(generic-package))

