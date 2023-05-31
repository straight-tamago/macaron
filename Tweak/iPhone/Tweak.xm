#import "Tweak.h"
#import <rootless.h>

//var
HBPreferences *preferences;

//prefs
BOOL enabled = NO;

%group Tweak
%hook SBDockView
%property (nonatomic, retain) FLAnimatedImageView *dockImageView; // 追記
%property (nonatomic, retain) UIVisualEffectView *visualEffectView; // 追記
- (void)layoutSubviews {
	%orig;

	UIVisualEffect *blurEffect;
	blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
	self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	[self.visualEffectView setClipsToBounds:YES];
	[self.visualEffectView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

	if (self.dockImageView != nil) {
		[self.dockImageView setFrame:self.backgroundView.bounds];
		self.visualEffectView.frame = self.dockImageView.bounds; 
		return;
	}

	// Blur
	[self.dockImageView addSubview:self.visualEffectView];

	[[self backgroundView].layer setMasksToBounds:YES]; // backgroundViewのサブビューを自身に合わせて表示
	NSData *data = ([GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"] != nil) ? [GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"] : [NSData dataWithContentsOfFile:ROOT_PATH_NS(@"/Library/PreferenceBundles/Macaron.bundle/default.png")]; //画像をNSDataで読み込む
	const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
	self.dockImageView = [[FLAnimatedImageView alloc] init]; // 初期化

	if ((unsigned long)dataBuffer[0] == 71 && (unsigned long)dataBuffer[1] == 73 && (unsigned long)dataBuffer[2] == 70) [self.dockImageView setAnimatedImage:[FLAnimatedImage animatedImageWithGIFData:data]]; // 画像を設定する
	else [self.dockImageView setImage:[UIImage imageWithData:data]]; // 画像を設定する

	[self.dockImageView setContentMode:UIViewContentModeScaleAspectFill]; // アスペクトを維持したままViewに全体表示
	[self.dockImageView setClipsToBounds:YES]; // 親のViewに合わせて表示
	[self.dockImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight]; //自動で親のViewのサイズにレイアウトする。
	[self.backgroundView addSubview:self.dockImageView]; // backgroundViewのサブビューにdockImageViewを追加する
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
