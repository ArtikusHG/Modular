//All important items are now in a separate header file 
#import "Modular.h"


%hook CCUIControlCenterContainerView
- (void)setRevealPercentage:(CGFloat)revealPercentage {
// Remove the original view
for (UIView *subview in self.subviews) {
  subview.alpha = 0;
  subview.hidden = YES;
}
// Add some stuff...
// The blur
blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
blurView.frame = [UIScreen mainScreen].bounds;
[blurView setAlpha:0.95];
[self addSubview:blurView];

// The dark thingy at the top
UIView *darkView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height / 3)];
[darkView setBackgroundColor: [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.5]];
[self addSubview:darkView];

// Power off button
UIButton *powerOff = [UIButton buttonWithType:UIButtonTypeRoundedRect];
powerOff.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75,10,150,35);
[powerOff setTitle:@"Power off" forState:UIControlStateNormal];
[powerOff addTarget: self action:@selector(powerOff) forControlEvents:UIControlEventTouchUpInside];
[powerOff setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
[powerOff.titleLabel setFont:[UIFont systemFontOfSize:25]];
[darkView addSubview:powerOff];

// Reboot button
UIButton *reBoot = [UIButton buttonWithType:UIButtonTypeRoundedRect];
reBoot.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75,75,150,35);
[reBoot setTitle:@"Reboot" forState:UIControlStateNormal];
[reBoot addTarget: self action:@selector(reBoot) forControlEvents:UIControlEventTouchUpInside];
[reBoot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
[reBoot.titleLabel setFont:[UIFont systemFontOfSize:25]];
[darkView addSubview:reBoot];

//Respring Button
UIButton *reSpring = [UIButton buttonWithType:UIButtonTypeRoundedRect];
reSpring.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75,140,150,35);
[reSpring setTitle:@"Respring" forState:UIControlStateNormal];
[reSpring addTarget: self action:@selector(respring) forControlEvents:UIControlEventTouchUpInside];
[reSpring setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
[reSpring.titleLabel setFont:[UIFont systemFontOfSize:25]];
[darkView addSubview:reSpring];

//WiFi Button
UIView *wifi = [[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4)];
[self addSubview:wifi];
UIImageView *wifiImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:wifiImagePath]];
wifiImage.frame = CGRectMake(6,-10,80,80);
[wifi addSubview:wifiImage];
UITapGestureRecognizer *wifiGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wifi)]autorelease];
[wifiGesture setNumberOfTouchesRequired:1];
[wifi addGestureRecognizer:wifiGesture];

//Bluetooh button
UIView *bluetooth = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - [UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4)];
[self addSubview:bluetooth];
UITapGestureRecognizer *bluetoothGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bluetooth)]autorelease];
[wifiGesture setNumberOfTouchesRequired:1];
[bluetooth addGestureRecognizer:bluetoothGesture];
UIImageView *bluetoothImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:bluetoothImagePath]];
bluetoothImage.frame = CGRectMake(10,0,60,60);
[bluetooth addSubview:bluetoothImage];

//Airplane button
UIView *airplane = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4)];
[self addSubview:airplane];
UITapGestureRecognizer *airplaneGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(airplaneToggle)]autorelease];
[airplaneGesture setNumberOfTouchesRequired:1];
[airplane addGestureRecognizer:airplaneGesture];
UIImageView *airplaneImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:airplaneImagePath];
airplaneImage.frame = CGRectMake(7,0,60,60);
[airplane addSubview:airplaneImage];

//Cellular data button
UIView *data = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4,[UIScreen mainScreen].bounds.size.width / 4)];
UITapGestureRecognizer *dataGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mobileData)]autorelease];
[dataGesture setNumberOfTouchesRequired:1];
[data addGestureRecognizer:dataGesture];
UIImageView *dataImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:dataImagePath]];
dataImage.frame = CGRectMake(0,-8,80,80);
[data addSubview:dataImage];
[self addSubview:data];

//Settings button 
UIView *settings = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2,[UIScreen mainScreen].bounds.size.height - 260,[UIScreen mainScreen].bounds.size.width / 2,[UIScreen mainScreen].bounds.size.width / 2)];
UITapGestureRecognizer *settingsGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settings)]autorelease];
[settingsGesture setNumberOfTouchesRequired:1];
[settings addGestureRecognizer:settingsGesture];
UIImageView *settingsImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:settingsImagePath]];
settingsImage.frame = CGRectMake(15,10,140,140);
[settings addSubview:settingsImage];
[self addSubview:settings];

//battery button
UIView *battery = [[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 260,[UIScreen mainScreen].bounds.size.width / 2,[UIScreen mainScreen].bounds.size.width / 2)];
UITapGestureRecognizer *batteryGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lowPowerMode)]autorelease];
[batteryGesture setNumberOfTouchesRequired:1];
[battery addGestureRecognizer:batteryGesture];
UIImageView *batteryImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:batteryImagePath]];
batteryImage.frame = CGRectMake(20,50,120,60);
[battery addSubview:batteryImage];
[self addSubview:battery];


// Brightness slider
slider = [[UISlider alloc] initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.height / 2.3,[UIScreen mainScreen].bounds.size.width - 20,35)];
[slider addTarget:self action:@selector(brightness) forControlEvents:UIControlEventValueChanged];
[slider setBackgroundColor:[UIColor clearColor]];
slider.minimumValue = 0.0;
slider.maximumValue = 1.0;
slider.continuous = YES;
slider.value = [UIScreen mainScreen].brightness;
[self addSubview:slider];
UILabel *brightness = [[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height / 2.9,[UIScreen mainScreen].bounds.size.width,50)];
brightness.text = @"Brightness";
brightness.textColor = [UIColor whiteColor];
brightness.textAlignment = NSTextAlignmentCenter;
[brightness setFont:[UIFont systemFontOfSize:25]];
[self addSubview:brightness];


// Separators
UIView *sep1 = [[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 100,[UIScreen mainScreen].bounds.size.width,3)];
[sep1 setBackgroundColor: [UIColor whiteColor]];
[sep1 setAlpha:0.5];
[self addSubview:sep1];

UIView *sep2 = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 1.5,[UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.height / 3.3 - 100,3,[UIScreen mainScreen].bounds.size.height / 3.3)];
[sep2 setBackgroundColor: [UIColor whiteColor]];
[sep2 setAlpha:0.5];
[self addSubview:sep2];

UIView *sep3 = [[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height / 1.9 - 6,[UIScreen mainScreen].bounds.size.width,3)];
[sep3 setBackgroundColor: [UIColor whiteColor]];
[sep3 setAlpha:0.5];
[self addSubview:sep3];
/* [wifi setAlpha:revealPercentage];
[bluetooth setAlpha:revealPercentage];
[airplane setAlpha:revealPercentage];
[data setAlpha:revealPercentage];
[battery setAlpha:revealPercentage];
[settings setAlpha:revealPercentage]; */
	
if (revealPercentage < 0.3) {
  for (UIView *subview in self.subviews) {
    subview.alpha = 0;
    subview.hidden = YES;
  }
}
}

%new
- (void)brightness {
  [[objc_getClass("SBBrightnessController") sharedBrightnessController] setBrightnessLevel:slider.value];
}
%new
-(void)powerOff {
[[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:0];
}
%new
-(void)reBoot {
[[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:1];
}
%new
	

-(void)respring {	
	 [[objc_getClass("FBSystemService") sharedInstance] exitAndRelaunch:YES];	
}


%new
- (void)wifi {
		// Fix for iOS 8 - iOS 10 for URL schemes :P
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"prefs:root=WIFI"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
			} 	
			
			else {
			 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=WIFI"]];
			
		}	
}


%new
- (void)bluetooth {
	// Fix for iOS 8 - iOS 10 for URL schemes :P
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"prefs:root=Bluetooth"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Bluetooth"]];
			} 	
			
			else {
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Bluetooth"]];
			
		 }	
}

%new
- (void)airplaneToggle {
  if([[%c(SBTelephonyManager) sharedTelephonyManager] isInAirplaneMode]) {
  [[%c(SBTelephonyManager) sharedTelephonyManager] setIsInAirplaneMode:NO];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Airplane mode disabled"
  message:nil
  delegate:self
  cancelButtonTitle:@"Ok"
  otherButtonTitles:nil];
  [alert show];
  } else {
    [[%c(SBTelephonyManager) sharedTelephonyManager] setIsInAirplaneMode:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Airplane mode enabled"
    message:nil
    delegate:self
    cancelButtonTitle:@"Ok"
    otherButtonTitles:nil];
    [alert show];
  }
}
%new
- (void)mobileData {
	// Fix for iOS 8 - iOS 10 for URL schemes :P
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"]];
			} 	
			
			else {
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"]];
			
			}	
}

%new
- (void)settings {
   // Fix for iOS 8 - iOS 10 for URL schemes :P
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"prefs:root"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root"]];
			} 	
			
			else {
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root"]];
			
			}	
}
%new

- (void)lowPowerMode {
  if ([[objc_getClass("_CDBatterySaver") batterySaver] getPowerMode] == 0) {
    [[%c(_CDBatterySaver) batterySaver] setPowerMode:1 error:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Low Power mode enabled"
    message:nil
    delegate:self
    cancelButtonTitle:@"Ok"
    otherButtonTitles:nil];
    [alert show];
} else {
  [[%c(_CDBatterySaver) batterySaver] setPowerMode:0 error:nil];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Low Power mode disabled"
  message:nil
  delegate:self
  cancelButtonTitle:@"Ok"
  otherButtonTitles:nil];
  [alert show];
}
}
%end
