################################################################################
#
# ams5915
#
################################################################################

AMS5915_VERSION = ad73ed982d416fecf64637e23eb0056eecc0a303
AMS5915_SITE = https://github.com/sittner/ams5915-mod.git
AMS5915_SITE_METHOD = git
AMS5915_LICENSE = GPL-2.0
AMS5915_LICENSE_FILES = COPYING

AMS5915_MODULE_MAKE_OPTS = CONFIG_AMS5915=m

$(eval $(kernel-module))
$(eval $(generic-package))

