#import "Tweak.h"
#import <GcUniversal/GcImagePickerUtils.h>

//prefs
BOOL enabled = NO;

/*
1. [self dockView].backgroundView にUIImageViewを追加する。
2. UIImageViewにGCUniversal...を用いて画像をセットする。
*/

%group Tweak
%hook SBFloatingDockViewController
%property (nonatomic, retain) FLAnimatedImageView *dockImageView_GIF; // 追記
%property (nonatomic, retain) UIImageView *dockImageView; // 追記
- (void)viewDidLoad {
	%orig;
	[[[self dockView] backgroundView].layer setMasksToBounds:YES]; // backgroundViewのサブビューを自身に合わせて表示
	NSData *data = [GcImagePickerUtils dataFromDefaults: @"com.misakaproject.macaron" withKey: @"kDockImage"]; //画像をNSDataで読み込む
	const unsigned char *dataBuffer = (const unsigned char *)[data bytes];

	if ((unsigned long)dataBuffer[0] == 71 &&
		(unsigned long)dataBuffer[1] == 73 &&
		(unsigned long)dataBuffer[2] == 70){
		// GIFの場合
		FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData: data];
		self.dockImageView_GIF = [[FLAnimatedImageView alloc] init]; // 初期化
		self.dockImageView_GIF.animatedImage = image; // 画像を設定する
		[self.dockImageView_GIF setContentMode:UIViewContentModeScaleAspectFill]; // アスペクトを維持したままViewに全体表示
		[self.dockImageView_GIF setClipsToBounds:YES]; // 親のViewに合わせて表示
		[self.dockImageView_GIF setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight]; //自動で親のViewのサイズにレイアウトする。
		[[self dockView].backgroundView addSubview:self.dockImageView_GIF]; // backgroundViewのサブビューにdockImageViewを追加する
	}else{
		// それ以外
		self.dockImageView = [[UIImageView alloc] init]; // 初期化
		[self.dockImageView setImage:[UIImage imageWithData:data]]; // 画像を設定する
		[self.dockImageView setContentMode:UIViewContentModeScaleAspectFill]; // アスペクトを維持したままViewに全体表示
		[self.dockImageView setClipsToBounds:YES]; // 親のViewに合わせて表示
		[self.dockImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight]; //自動で親のViewのサイズにレイアウトする。
		[[self dockView].backgroundView addSubview:self.dockImageView]; // backgroundViewのサブビューにdockImageViewを追加する
	}
}
%end
%end

static void loadPreferences() {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	enabled = ([defaults objectForKey:@"kEnabled" inDomain:@"com.misakaproject.macaron"] != nil) ? [[defaults objectForKey:@"kEnabled" inDomain:@"com.misakaproject.macaron"] boolValue] : NO;
}

%ctor {
	loadPreferences();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, (CFStringRef)@"com.misakaproject.macaron/ReloadPrefs", NULL, CFNotificationSuspensionBehaviorCoalesce);
    if (enabled) %init(Tweak);
}
