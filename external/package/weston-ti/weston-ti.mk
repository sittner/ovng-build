################################################################################
#
# weston-ti
#
################################################################################

WESTON_TI_VERSION = 8.0.0
WESTON_TI_SITE = http://wayland.freedesktop.org/releases
WESTON_TI_SOURCE = weston-$(WESTON_TI_VERSION).tar.xz
WESTON_TI_LICENSE = MIT
WESTON_TI_LICENSE_FILES = COPYING

WESTON_TI_DEPENDENCIES = host-pkgconf wayland wayland-protocols ti-img-sgx-um \
	libxkbcommon pixman libpng jpeg udev cairo libinput libdrm

WESTON_TI_CONF_OPTS = \
	-Dbuild.pkg_config_path=$(HOST_DIR)/lib/pkgconfig \
	-Dbackend-headless=false \
	-Dcolor-management-colord=false \
	-Dremoting=false

# Uses VIDIOC_EXPBUF, only available from 3.8+
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_8),y)
WESTON_TI_CONF_OPTS += -Dsimple-clients=dmabuf-v4l
else
WESTON_TI_CONF_OPTS += -Dsimple-clients=
endif

ifeq ($(BR2_PACKAGE_DBUS)$(BR2_PACKAGE_SYSTEMD),yy)
WESTON_TI_CONF_OPTS += -Dlauncher-logind=true
WESTON_TI_DEPENDENCIES += dbus systemd
else
WESTON_TI_CONF_OPTS += -Dlauncher-logind=false
endif

ifeq ($(BR2_PACKAGE_WEBP),y)
WESTON_TI_CONF_OPTS += -Dimage-webp=true
WESTON_TI_DEPENDENCIES += webp
else
WESTON_TI_CONF_OPTS += -Dimage-webp=false
endif

# weston-launch must be u+s root in order to work properly
ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
define WESTON_TI_PERMISSIONS
	/usr/bin/weston-launch f 4755 0 0 - - - - -
endef
define WESTON_TI_USERS
	- - weston-launch -1 - - - - Weston launcher group
endef
WESTON_TI_CONF_OPTS += -Dweston-launch=true
WESTON_TI_DEPENDENCIES += linux-pam
else
WESTON_TI_CONF_OPTS += -Dweston-launch=false
endif

WESTON_TI_CONF_OPTS += -Drenderer-gl=true
WESTON_TI_CONF_OPTS += -Dbackend-rdp=false
WESTON_TI_CONF_OPTS += -Dbackend-fbdev=false
WESTON_TI_CONF_OPTS += -Dbackend-drm=true
WESTON_TI_CONF_OPTS += -Dbackend-x11=false
WESTON_TI_CONF_OPTS += -Dbackend-default=drm

ifeq ($(BR2_PACKAGE_WESTON_TI_XWAYLAND),y)
WESTON_TI_CONF_OPTS += -Dxwayland=true
WESTON_TI_DEPENDENCIES += cairo libepoxy libxcb xlib_libX11 xlib_libXcursor
else
WESTON_TI_CONF_OPTS += -Dxwayland=false
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
WESTON_TI_CONF_OPTS += -Dbackend-drm-screencast-vaapi=true
WESTON_TI_DEPENDENCIES += libva
else
WESTON_TI_CONF_OPTS += -Dbackend-drm-screencast-vaapi=false
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
WESTON_TI_CONF_OPTS += -Dcolor-management-lcms=true
WESTON_TI_DEPENDENCIES += lcms2
else
WESTON_TI_CONF_OPTS += -Dcolor-management-lcms=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
WESTON_TI_CONF_OPTS += -Dsystemd=true
WESTON_TI_DEPENDENCIES += systemd
else
WESTON_TI_CONF_OPTS += -Dsystemd=false
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
WESTON_TI_CONF_OPTS += -Dtest-junit-xml=true
WESTON_TI_DEPENDENCIES += libxml2
else
WESTON_TI_CONF_OPTS += -Dtest-junit-xml=false
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE),y)
WESTON_TI_CONF_OPTS += -Dpipewire=true
WESTON_TI_DEPENDENCIES += pipewire
else
WESTON_TI_CONF_OPTS += -Dpipewire=false
endif

ifeq ($(BR2_PACKAGE_WESTON_TI_DEMO_CLIENTS),y)
WESTON_TI_CONF_OPTS += -Ddemo-clients=true
WESTON_TI_DEPENDENCIES += pango
else
WESTON_TI_CONF_OPTS += -Ddemo-clients=false
endif

$(eval $(meson-package))
