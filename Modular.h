#include <spawn.h>
#include <signal.h>

//Views
UIVisualEffect *blurEffect;
UIVisualEffectView *blurView;
UIButton *wifi;
UISlider *slider;

//Image paths
NSString airplaneImagePath = @"/Library/Application Support/Modular/airplane.png";
NSString batteryImagePath = @"/Library/Application Support/Modular/battery.png";
NSString bluetoothImagePath = @"/Library/Application Support/Modular/bluetooth.png";
NSString dataImagePath = @"/Library/Application Support/Modular/data.png";
NSString settingsImagePath = @"/Library/Application Support/Modular/settings.png";
NSString wifiImagePath = @"/Library/Application Support/Modular/wifi.png";

// Needed interfaces
@interface SBBrightnessController
+ (id)sharedBrightnessController;
- (void)setBrightnessLevel:(float)arg1;
@end
@interface _CDBatterySaver
+ (id)batterySaver;
- (long long)getPowerMode;
- (BOOL)setPowerMode:(long long)arg1 error:(id*)arg2;
@end
@interface SBTelephonyManager
+ (id)sharedTelephonyManager;
- (BOOL)isInAirplaneMode;
- (void)setIsInAirplaneMode:(BOOL)arg1;
@end
@interface UIButton()
- (void)_setImageColor:(id)arg1 forState:(unsigned int)arg2;
@end
@interface CCUIControlCenterContainerView : UIView
@end
@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)shutdownAndReboot:(BOOL)arg1;
@end
@interface SBWiFiManager
+(id)sharedInstance;
-(void)setWiFiEnabled:(BOOL)enabled;
-(bool)wiFiEnabled;
@end