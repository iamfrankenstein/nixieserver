#
# This software is licensed under the Public Domain.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nixieserver
PKG_VERSION:=0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/nixieserver
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=FTDI based nixie clock!
	DEPENDS:=+libusb-compat +libftdi +ntpclient
endef

define Package/nixieserver/description
	This is a server for a ftdi based nixie clock. By using the bitbang mode to drive multiple shift registers (74hc595). 
	For more info check the github https://github.com/iamfrankenstein/Nixie_Server
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/nixieserver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nixieserver $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/nixie.initd $(1)/etc/init.d/nixieserver
endef

$(eval $(call BuildPackage,nixieserver))
