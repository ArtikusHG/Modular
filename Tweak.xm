#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
UIButton *wifi;
UISlider *brightness;
UISlider *volume;
UITapGestureRecognizer *batteryGesture;

// Needed interfaces
@interface VolumeControl
+ (id)sharedVolumeControl;
- (void)_changeVolumeBy:(float)arg1;
- (float)volume;
@end
@interface SBBrightnessController
+ (id)sharedBrightnessController;
- (void)setBrightnessLevel:(float)arg1;
@end
@interface _CDBatterySaver
+ (id)batterySaver;
- (long long)getPowerMode;
- (BOOL)setPowerMode:(long long)arg1 error:(NSError **)arg2;
@end
@interface CCUIControlCenterContainerView : UIView
@end
@interface SBWiFiManager
+(id)sharedInstance;
-(void)setWiFiEnabled:(BOOL)enabled;
-(bool)wiFiEnabled;
@end
@interface UIApplication ()
- (long long)activeInterfaceOrientation;
@end

// iOS 10
%hook CCUIControlCenterContainerView
- (void)setRevealPercentage:(CGFloat)revealPercentage {
    // Remove the original view
    for (UIView *subview in self.subviews) {
        subview.alpha = 0;
        subview.hidden = YES;
    }
    
    CGFloat *screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat *screenHeight = UIScreen.mainScreen.bounds.size.height;
    
    // Brightness slider
    if (UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation)) {
        // Brightness slider
        brightness = [[UISlider alloc] initWithFrame:CGRectMake(10, screenWidth - 40, screenHeight - 20, 35)];
        [brightness addTarget:self action:@selector(brightness) forControlEvents:UIControlEventValueChanged];
        [brightness setBackgroundColor:[UIColor yellowColor]];
        brightness.layer.masksToBounds = YES;
        brightness.layer.cornerRadius = 5.0;
        brightness.minimumValue = 0.0;
        brightness.maximumValue = 1.0;
        brightness.continuous = YES;
        brightness.value = UIScreen.mainScreen.brightness;
        [self addSubview:brightness];
        
        // Volume slider
        volume = [[UISlider alloc] initWithFrame:CGRectMake(10,screenWidth -  screenHeight / 3 - 85, screenHeight - 20,35)];
        [volume addTarget:self action:@selector(setVolume:) forControlEvents:UIControlEventValueChanged];
        [volume setBackgroundColor:[UIColor colorWithRed:0.09 green:0.31 blue:0.66 alpha:1.0]];
        volume.layer.masksToBounds = YES;
        volume.layer.cornerRadius = 5.0;
        volume.minimumValue = 0.0000;
        volume.maximumValue = 1.0000;
        volume.continuous = YES;
        volume.value = [[objc_getClass("VolumeControl") sharedVolumeControl] volume];
        [self addSubview:volume];
        
        // Wifi view
        UIView *wifi = [[UIView alloc]initWithFrame:CGRectMake(10, screenWidth -  screenHeight / 3 - 40, screenHeight / 3 - 15, screenHeight / 3 - 15)];
        [wifi setBackgroundColor:[UIColor blueColor]];
        wifi.layer.masksToBounds = YES;
        wifi.layer.cornerRadius = 5.0;
        [self addSubview:wifi];
        // Wifi icon
        UIImageView *wifiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi.png"]];
        wifiImage.frame = wifi.bounds;
        [wifi addSubview:wifiImage];
        // Wifi gesture
        UITapGestureRecognizer *wifiGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wifi)] autorelease];
        [wifiGesture setNumberOfTouchesRequired:1];
        [wifi addGestureRecognizer:wifiGesture];
        
        // Battery view
        UIView *battery = [[UIView alloc]initWithFrame:CGRectMake(screenHeight / 3 + 7.5, screenWidth -  screenHeight / 3 - 40, screenHeight / 3 - 15, screenHeight / 3 - 15)];
        // Battery image
        UIImageView *batteryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"battery.png"]];
        batteryImage.frame = battery.bounds;
        [battery setBackgroundColor:[UIColor yellowColor]];
        [battery addSubview:batteryImage];
        battery.layer.masksToBounds = YES;
        battery.layer.cornerRadius = 5.0;
        // Battery gesture
        UITapGestureRecognizer *batteryGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lowPowerMode)] autorelease];
        [batteryGesture setNumberOfTouchesRequired:1];
        [battery addGestureRecognizer:batteryGesture];
        [self addSubview:battery];
        
        // Settings view
        UIView *settings = [[UIView alloc]initWithFrame:CGRectMake( screenHeight / 3 +  screenHeight / 3 + 5,screenWidth -  screenHeight / 3 - 40, screenHeight / 3 - 15, screenHeight / 3 - 15)];
        [settings setBackgroundColor:[UIColor grayColor]];
        settings.layer.masksToBounds = YES;
        settings.layer.cornerRadius = 5.0;
        // Settings gesture
        UITapGestureRecognizer *settingsGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settings)] autorelease];
        [settingsGesture setNumberOfTouchesRequired:1];
        [settings addGestureRecognizer:settingsGesture];
        // Settings image
        UIImageView *settingsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings.png"]];
        settingsImage.frame = settings.bounds;
        [settings addSubview:settingsImage];
        
        [self addSubview:settings];
    } else {
        brightness = [[UISlider alloc] initWithFrame:CGRectMake(10, screenHeight - 40, screenWidth - 20, 35)];
        [brightness addTarget:self action:@selector(brightness) forControlEvents:UIControlEventValueChanged];
        [brightness setBackgroundColor:UIColor.yellowColor];
        brightness.layer.masksToBounds = YES;
        brightness.layer.cornerRadius = 5.0;
        brightness.minimumValue = 0.0;
        brightness.maximumValue = 1.0;
        brightness.continuous = YES;
        brightness.value = UIScreen.mainScreen.brightness;
        [self addSubview:brightness];
        
        // Volume slider
        volume = [[UISlider alloc] initWithFrame:CGRectMake(10,  screenHeight - screenWidth / 3 - 85,screenWidth - 20,35)];
        [volume addTarget:self action:@selector(setVolume:) forControlEvents:UIControlEventValueChanged];
        [volume setBackgroundColor:[UIColor colorWithRed:0.09 green:0.31 blue:0.66 alpha:1.0]];
        volume.layer.masksToBounds = YES;
        volume.layer.cornerRadius = 5.0;
        volume.minimumValue = 0.0000;
        volume.maximumValue = 1.0000;
        volume.continuous = YES;
        volume.value = [[objc_getClass("VolumeControl") sharedVolumeControl] volume];
        [self addSubview:volume];
        
        // Wifi view
        UIView *wifi = [[UIView alloc]initWithFrame:CGRectMake(10, screenHeight - screenWidth / 3 - 40,screenWidth / 3 - 15,screenWidth / 3 - 15)];
        [wifi setBackgroundColor:[UIColor blueColor]];
        wifi.layer.masksToBounds = YES;
        wifi.layer.cornerRadius = 5.0;
        [self addSubview:wifi];
        // Wifi icon
        UIImageView *wifiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi.png"]];
        wifiImage.frame = wifi.bounds;
        [wifi addSubview:wifiImage];
        // Wifi gesture
        UITapGestureRecognizer *wifiGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wifi)] autorelease];
        [wifiGesture setNumberOfTouchesRequired:1];
        [wifi addGestureRecognizer:wifiGesture];
        
        // Battery view
        UIView *battery = [[UIView alloc]initWithFrame:CGRectMake(screenWidth / 3 + 7.5, screenHeight - screenWidth / 3 - 40,screenWidth / 3 - 15,screenWidth / 3 - 15)];
        // Battery image
        UIImageView *batteryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"battery.png"]];
        batteryImage.frame = battery.bounds;
        [battery setBackgroundColor:[UIColor yellowColor]];
        [battery addSubview:batteryImage];
        battery.layer.masksToBounds = YES;
        battery.layer.cornerRadius = 5.0;
        // Battery gesture
        UITapGestureRecognizer *batteryGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lowPowerMode)] autorelease];
        [batteryGesture setNumberOfTouchesRequired:1];
        [battery addGestureRecognizer:batteryGesture];
        [self addSubview:battery];
        
        // Settings view
        UIView *settings = [[UIView alloc] initWithFrame:CGRectMake(screenWidth / 3 + screenWidth / 3 + 5, screenHeight - screenWidth / 3 - 40, screenWidth / 3 - 15, screenWidth / 3 - 15)];
        [settings setBackgroundColor:[UIColor grayColor]];
        settings.layer.masksToBounds = YES;
        settings.layer.cornerRadius = 5.0;
        // Settings gesture
        UITapGestureRecognizer *settingsGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settings)] autorelease];
        [settingsGesture setNumberOfTouchesRequired:1];
        [settings addGestureRecognizer:settingsGesture];
        // Settings image
        UIImageView *settingsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings.png"]];
        settingsImage.frame = settings.bounds;
        [settings addSubview:settingsImage];
        
        [self addSubview:settings];
    }
    if (revealPercentage < 0.3) {
        for (UIView *subview in self.subviews) {
            subview.alpha = 0;
            subview.hidden = YES;
        }
    }
}

%new
- (void)setVolume:(UISlider *)sender {
    [[objc_getClass("VolumeControl") sharedVolumeControl] _changeVolumeBy:sender.value - [[objc_getClass("VolumeControl") sharedVolumeControl] volume]];
}

%new
- (void)brightness {
    [[objc_getClass("SBBrightnessController") sharedBrightnessController] setBrightnessLevel:brightness.value];
}

%new
- (void)wifi {
    NSString *alertMessage;
    if ([[%c(SBWiFiManager) sharedInstance] wiFiEnabled]) {
        [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:NO];
        alertMessage = @"WiFi disabled";
    } else {
        [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:YES];
        alertMessage = @"WiFi enabled";
    }
    [[[UIAlertView alloc] initWithTitle:alertMessage message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

%new
- (void)settings {
    [[SpringBoard sharedApplication] applicationOpenURL:[NSURL URLWithString:@"prefs:root"]];
}

%new
- (void)lowPowerMode {
    NSString *alertMessage;
    if ([[objc_getClass("_CDBatterySaver") batterySaver] getPowerMode] == 0) {
        [[%c(_CDBatterySaver) batterySaver] setPowerMode:1 error:NULL];
        alertMessage = @"Low Power mode enabled";
    } else {
        [[%c(_CDBatterySaver) batterySaver] setPowerMode:0 error:nil];
        alertMessage = @"Low Power mode disabled";
    }
    [[[UIAlertView alloc] initWithTitle: message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
%end

// iOS 9 / 8 / 7
%hook SBControlCenterViewController
-(void)setRevealPercentage:(double)arg1 {
    for (UIView *subview in [self view].subviews) {
        subview.alpha = 0;
        subview.hidden = YES;
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        // Brightness slider
        brightness = [[UISlider alloc] initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.width - 40,[UIScreen mainScreen].bounds.size.height - 20,35)];
        [brightness addTarget:self action:@selector(brightness) forControlEvents:UIControlEventValueChanged];
        [brightness setBackgroundColor:[UIColor yellowColor]];
        brightness.layer.masksToBounds = YES;
        brightness.layer.cornerRadius = 5.0;
        brightness.minimumValue = 0.0;
        brightness.maximumValue = 1.0;
        brightness.continuous = YES;
        brightness.value = [UIScreen mainScreen].brightness;
        [[self view] addSubview:brightness];
        // Volume slider
        volume = [[UISlider alloc] initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.height / 3 - 85,[UIScreen mainScreen].bounds.size.height - 20,35)];
        [volume addTarget:self action:@selector(setVolume:) forControlEvents:UIControlEventValueChanged];
        [volume setBackgroundColor:[UIColor colorWithRed:0.09 green:0.31 blue:0.66 alpha:1.0]];
        volume.layer.masksToBounds = YES;
        volume.layer.cornerRadius = 5.0;
        volume.minimumValue = 0.0000;
        volume.maximumValue = 1.0000;
        volume.continuous = YES;
        volume.value = [[objc_getClass("VolumeControl") sharedVolumeControl] volume];
        [[self view] addSubview:volume];
        // Wifi view
        UIView *wifi = [[UIView alloc]initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.height / 3 - 40,[UIScreen mainScreen].bounds.size.height / 3 - 15,[UIScreen mainScreen].bounds.size.height / 3 - 15)];
        [wifi setBackgroundColor:[UIColor blueColor]];
        wifi.layer.masksToBounds = YES;
        wifi.layer.cornerRadius = 5.0;
        [[self view] addSubview:wifi];
        // Wifi icon
        UIImageView *wifiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi.png"]];
        wifiImage.frame = wifi.bounds;
        [wifi addSubview:wifiImage];
        // Wifi gesture
        UITapGestureRecognizer *wifiGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wifi)]autorelease];
        [wifiGesture setNumberOfTouchesRequired:1];
        [wifi addGestureRecognizer:wifiGesture];
        // Battery view
        UIView *battery = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height / 3 + 7.5,[UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.height / 3 - 40,[UIScreen mainScreen].bounds.size.height / 3 - 15,[UIScreen mainScreen].bounds.size.height / 3 - 15)];
        // Battery image
        UIImageView *batteryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"battery.png"]];
        batteryImage.frame = battery.bounds;
        UIImageView *respringImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"respring.png"]];
        respringImage.frame = battery.bounds;
        // Battery view
        if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
            [battery setBackgroundColor:[UIColor greenColor]];
            [battery addSubview:respringImage];
        } else {
            [battery setBackgroundColor:[UIColor yellowColor]];
            [battery addSubview:batteryImage];
        }
        battery.layer.masksToBounds = YES;
        battery.layer.cornerRadius = 5.0;
        // Battery gesture
        UITapGestureRecognizer *batteryGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lowPowerMode)]autorelease];
        [batteryGesture setNumberOfTouchesRequired:1];
        [battery addGestureRecognizer:batteryGesture];
        [[self view] addSubview:battery];
        // Settings view
        UIView *settings = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height / 3 + [UIScreen mainScreen].bounds.size.height / 3 + 5,[UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.height / 3 - 40,[UIScreen mainScreen].bounds.size.height / 3 - 15,[UIScreen mainScreen].bounds.size.height / 3 - 15)];
        [settings setBackgroundColor:[UIColor grayColor]];
        settings.layer.masksToBounds = YES;
        settings.layer.cornerRadius = 5.0;
        // Settings gesture
        UITapGestureRecognizer *settingsGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settings)]autorelease];
        [settingsGesture setNumberOfTouchesRequired:1];
        [settings addGestureRecognizer:settingsGesture];
        // Settings image
        UIImageView *settingsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings.png"]];
        settingsImage.frame = settings.bounds;
        [settings addSubview:settingsImage];
        
        [[self view] addSubview:settings];
    } else {
        brightness = [[UISlider alloc] initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.height - 40,[UIScreen mainScreen].bounds.size.width - 20,35)];
        [brightness addTarget:self action:@selector(brightness) forControlEvents:UIControlEventValueChanged];
        [brightness setBackgroundColor:[UIColor yellowColor]];
        brightness.layer.masksToBounds = YES;
        brightness.layer.cornerRadius = 5.0;
        brightness.minimumValue = 0.0;
        brightness.maximumValue = 1.0;
        brightness.continuous = YES;
        brightness.value = [UIScreen mainScreen].brightness;
        [[self view] addSubview:brightness];
        // Volume slider
        volume = [[UISlider alloc] initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 3 - 85,[UIScreen mainScreen].bounds.size.width - 20,35)];
        [volume addTarget:self action:@selector(setVolume:) forControlEvents:UIControlEventValueChanged];
        [volume setBackgroundColor:[UIColor colorWithRed:0.09 green:0.31 blue:0.66 alpha:1.0]];
        volume.layer.masksToBounds = YES;
        volume.layer.cornerRadius = 5.0;
        volume.minimumValue = 0.0000;
        volume.maximumValue = 1.0000;
        volume.continuous = YES;
        volume.value = [[objc_getClass("VolumeControl") sharedVolumeControl] volume];
        [[self view] addSubview:volume];
        // Wifi view
        UIView *wifi = [[UIView alloc]initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 3 - 40,[UIScreen mainScreen].bounds.size.width / 3 - 15,[UIScreen mainScreen].bounds.size.width / 3 - 15)];
        [wifi setBackgroundColor:[UIColor blueColor]];
        wifi.layer.masksToBounds = YES;
        wifi.layer.cornerRadius = 5.0;
        [[self view] addSubview:wifi];
        // Wifi icon
        UIImageView *wifiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi.png"]];
        wifiImage.frame = wifi.bounds;
        [wifi addSubview:wifiImage];
        // Wifi gesture
        UITapGestureRecognizer *wifiGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wifi)]autorelease];
        [wifiGesture setNumberOfTouchesRequired:1];
        [wifi addGestureRecognizer:wifiGesture];
        // Battery view
        UIView *battery = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3 + 7.5,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 3 - 40,[UIScreen mainScreen].bounds.size.width / 3 - 15,[UIScreen mainScreen].bounds.size.width / 3 - 15)];
        // Battery image
        UIImageView *batteryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"battery.png"]];
        batteryImage.frame = battery.bounds;
        UIImageView *respringImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"respring.png"]];
        respringImage.frame = battery.bounds;
        // Battery view
        if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
            [battery setBackgroundColor:[UIColor greenColor]];
            [battery addSubview:respringImage];
        } else {
            [battery setBackgroundColor:[UIColor yellowColor]];
            [battery addSubview:batteryImage];
        }
        battery.layer.masksToBounds = YES;
        battery.layer.cornerRadius = 5.0;
        // Battery gesture
        UITapGestureRecognizer *batteryGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lowPowerMode)]autorelease];
        [batteryGesture setNumberOfTouchesRequired:1];
        [battery addGestureRecognizer:batteryGesture];
        [[self view] addSubview:battery];
        // Settings view
        UIView *settings = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3 + [UIScreen mainScreen].bounds.size.width / 3 + 5,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 3 - 40,[UIScreen mainScreen].bounds.size.width / 3 - 15,[UIScreen mainScreen].bounds.size.width / 3 - 15)];
        [settings setBackgroundColor:[UIColor grayColor]];
        settings.layer.masksToBounds = YES;
        settings.layer.cornerRadius = 5.0;
        // Settings gesture
        UITapGestureRecognizer *settingsGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settings)]autorelease];
        [settingsGesture setNumberOfTouchesRequired:1];
        [settings addGestureRecognizer:settingsGesture];
        // Settings image
        UIImageView *settingsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings.png"]];
        settingsImage.frame = settings.bounds;
        [settings addSubview:settingsImage];
        
        [[self view] addSubview:settings];
    }
}

%new
- (void)setVolume:(UISlider *)sender {
    [[objc_getClass("VolumeControl") sharedVolumeControl] _changeVolumeBy:sender.value - [[objc_getClass("VolumeControl") sharedVolumeControl] volume]];
}

%new
- (void)brightness {
    [[objc_getClass("SBBrightnessController") sharedBrightnessController] setBrightnessLevel:brightness.value];
}

%new
- (void)wifi {
    NSString *alertMessage;
    if ([[%c(SBWiFiManager) sharedInstance] wiFiEnabled]) {
        [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:NO];
        alertMessage = @"WiFi disabled";
    } else {
        [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:YES];
        alertMessage = @"WiFi enabled";
    }
    [[[UIAlertView alloc] initWithTitle:alertMessage message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

%new
- (void)settings {
    [[SpringBoard sharedApplication] applicationOpenURL:[NSURL URLWithString:@"prefs:root"]];
}

%new
- (void)lowPowerMode {
    // if on iOS 8 or 7, respring else toggle (or untoggle) low power mode
    if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        system("killall -9 SpringBoard");
    } else {
        NSString *alertMessage;
        if ([[objc_getClass("_CDBatterySaver") batterySaver] getPowerMode] == 0) {
            [[%c(_CDBatterySaver) batterySaver] setPowerMode:1 error:NULL];
            alertMessage = @"Low Power mode enabled";
        } else {
            [[%c(_CDBatterySaver) batterySaver] setPowerMode:0 error:nil];
            alertMessage = @"Low Power mode disabled";
        }
        [[[UIAlertView alloc] initWithTitle: message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
    }
}
%end
