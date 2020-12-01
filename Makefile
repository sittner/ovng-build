.PHONY: all clean realclean configure image brshell

BR2_DL_DIR := $(PWD)/downloads
BR2_HOME_DIR := $(PWD)/buildroot
BR2_BUILD_DIR := $(PWD)/build
BR2_EXTERNAL := $(PWD)/external
BR2_TARGET := ovng

export BR2_DL_DIR
export BR2_HOME_DIR
export BR2_BUILD_DIR
export BR2_EXTERNAL
export BR2_TARGET

export PATH := $(BR2_BUILD_DIR)/host/usr/bin:$(PATH)

all: image

configure: $(BR2_BUILD_DIR)/.config
$(BR2_BUILD_DIR)/.config:
	mkdir -p $(BR2_BUILD_DIR)
	$(MAKE) O=$(BR2_BUILD_DIR) -C $(BR2_HOME_DIR) $(BR2_TARGET)_defconfig

image: $(BR2_BUILD_DIR)/.config
	$(MAKE) -C $(BR2_BUILD_DIR) all

brshell: $(BR2_BUILD_DIR)/.config
	@ (cd $(BR2_BUILD_DIR) && PS1='BR2-$(BR2_TARGET):\u@\h:\w$$ ' bash --norc)

clean:
	rm -rf build

realclean: clean
	rm -r downloads

