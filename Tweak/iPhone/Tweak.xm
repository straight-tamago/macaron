#import "Tweak.h"
#import <rootless.h>

//var
HBPreferences *preferences;

//prefs
BOOL enabled = NO;

%group Tweak
%hook SBDockView
%property (nonatomic, retain) FLAnimatedImageView *dockImageView;
%property (nonatomic, retain) UIVisualEffectView *visualEffectView;
- (void)layoutSubviews {
	%orig;

	if (self.dockImageView != nil) {
		[self.dockImageView setFrame:self.backgroundView.bounds];
		[self.visualEffectView setFrame:self.backgroundView.bounds];
		return;
	}

	// backgroundView.layer
	[[self backgroundView].layer setMasksToBounds:YES];

	// 画像の取得
	NSData *data = ([GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"] != nil) ? [GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"] : [NSData dataWithContentsOfFile:ROOT_PATH_NS(@"/Library/PreferenceBundles/Macaron.bundle/default.png")]; //画像をNSDataで読み込む
	const unsigned char *dataBuffer = (const unsigned char *)[data bytes];

	// self.dockImageView
	self.dockImageView = [[FLAnimatedImageView alloc] init];
	if ((unsigned long)dataBuffer[0] == 71 && (unsigned long)dataBuffer[1] == 73 && (unsigned long)dataBuffer[2] == 70) [self.dockImageView setAnimatedImage:[FLAnimatedImage animatedImageWithGIFData:data]];
	else [self.dockImageView setImage:[UIImage imageWithData:data]];
	[self.dockImageView setContentMode:UIViewContentModeScaleAspectFill];
	[self.dockImageView setClipsToBounds:YES];
	[self.dockImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[self.backgroundView addSubview:self.dockImageView];

	// self.visualEffectView
	NSString *blurType = [preferences objectForKey:@"kBlurType"];
	UIBlurEffectStyle blurStyle = nil;
	if ([blurType isEqualToString:@"UIBlurEffectStyleRegular"]) blurStyle = UIBlurEffectStyleRegular;
	else if ([blurType isEqualToString:@"UIBlurEffectStyleProminent"]) blurStyle = UIBlurEffectStyleProminent;
	if (blurStyle) {
		UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:blurStyle];
		self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		[self.visualEffectView setClipsToBounds:YES];
		[self.visualEffectView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[self.dockImageView addSubview:self.visualEffectView];
	}
}
%end
%end

%ctor {
	// iPhone
	if (![[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]) return;

	// FloatingDockXVI
	if ([[[HBPreferences alloc] initWithIdentifier:@"com.nahtedetihw.floatingdockxvi"] boolForKey:@"enabled"] && [[NSFileManager defaultManager] fileExistsAtPath:ROOT_PATH_NS(@"/Library/MobileSubstrate/DynamicLibraries/FloatingDockXVI.dylib")]) return;

	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.misakaproject.macaron"];
	[preferences registerBool:&enabled default:NO forKey:@"kEnabled"];
	if (enabled) %init(Tweak);
}
