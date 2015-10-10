include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Cobalia
Cobalia_FILES = $(wildcard *.m)
Cobalia_INSTALL_PATH = /Library/PreferenceBundles
Cobalia_FRAMEWORKS = UIKit
Cobalia_PRIVATE_FRAMEWORKS = Preferences
Cobalia_LIBRARIES = cepheiprefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Cobalia.plist$(ECHO_END)
