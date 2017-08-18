THEOS_DEVICE_IP = 192.168.1.210
THEOS_DEVICE_PORT = 22
ARCHS = arm64
include ~/theos/makefiles/common.mk

TWEAK_NAME = Modular
Modular_FILES = Tweak.xm
Modular_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
