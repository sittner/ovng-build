################################################################################
#
# icm20948
#
################################################################################

ICM20948_VERSION = f0c76d41384131aaa456c934f0fb1785ffaafc30
ICM20948_SITE = https://github.com/sittner/icm20948-mod.git
ICM20948_SITE_METHOD = git
ICM20948_LICENSE = GPL-2.0
ICM20948_LICENSE_FILES = COPYING

ICM20948_MODULE_MAKE_OPTS = CONFIG_ICM20948=m

$(eval $(kernel-module))
$(eval $(generic-package))

