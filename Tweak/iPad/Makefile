TWEAK_NAME = MacaroniPad
$(TWEAK_NAME)_FILES = Tweak.xm $(wildcard ../Classes/*.m)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
$(TWEAK_NAME)_LIBRARIES = gcuniversal
$(TWEAK_NAME)_FRAMEWORKS += UIKit Foundation
# $(TWEAK_NAME)_PRIVATE_FRAMEWORKS =
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk