#import "Tweak.h"
#import <rootless.h>

//var
HBPreferences *preferences;

//prefs
BOOL enabled = NO;

%group Tweak
%hook SBFloatingDockViewController
%property (nonatomic, retain) FLAnimatedImageView *dockImageView; // 追記
- (void)viewDidLoad {
	%orig;
	[[[self dockView] backgroundView].layer setMasksToBounds:YES]; // backgroundViewのサブビューを自身に合わせて表示
	NSData *data = ([GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"] != nil) ? [GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"] : [NSData dataWithContentsOfFile:ROOT_PATH_NS(@"/Library/PreferenceBundles/Macaron.bundle/default.png")]; //画像をNSDataで読み込む
	const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
	self.dockImageView = [[FLAnimatedImageView alloc] init]; // 初期化

	if ((unsigned long)dataBuffer[0] == 71 && (unsigned long)dataBuffer[1] == 73 && (unsigned long)dataBuffer[2] == 70) [self.dockImageView setAnimatedImage:[FLAnimatedImage animatedImageWithGIFData:data]]; // 画像を設定する
	else [self.dockImageView setImage:[UIImage imageWithData:data]]; // 画像を設定する

	[self.dockImageView setContentMode:UIViewContentModeScaleAspectFill]; // アスペクトを維持したままViewに全体表示
	[self.dockImageView setClipsToBounds:YES]; // 親のViewに合わせて表示
	[self.dockImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight]; //自動で親のViewのサイズにレイアウトする。
	[[self dockView].backgroundView addSubview:self.dockImageView]; // backgroundViewのサブビューにdockImageViewを追加する
}
%end
%end

%ctor {
	NSString *modelName = [[UIDevice currentDevice] model];
	if ([modelName isEqualToString:@"iPhone"]) {
		// iPhoneの場合
	}
	else if ([modelName isEqualToString:@"iPad"]) {
		// iPad の場合
		preferences = [[HBPreferences alloc] initWithIdentifier:@"com.misakaproject.macaron"];
    		[preferences registerBool:&enabled default:NO forKey:@"kEnabled"];
    		if (enabled) %init(Tweak);
	}
}
