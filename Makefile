include theos/makefiles/common.mk

TWEAK_NAME = Cobalia
Cobalia_FILES = Tweak.xm HBCBAppSwitcherToggleItem.m HBCBAppSwitcherTogglesDataSource.m HBCBAppSwitcherToggleView.xm HBCBToggleContainer.x
Cobalia_FRAMEWORKS = AddressBookUI CoreGraphics UIKit
Cobalia_LIBRARIES = cephei flipswitch

BUNDLE_NAME = CobaliaFlipswitch
CobaliaFlipswitch_INSTALL_PATH = /Library/Application Support

SUBPROJECTS = prefs

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/DEBIAN$(ECHO_END)
	$(ECHO_NOTHING)cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postinst$(ECHO_END)

after-install::
ifeq ($(RESPRING),0)
	install.exec "killall Preferences; sleep 0.2; sbopenurl prefs:root=Cobalia"
else
	install.exec "spring"
endif
