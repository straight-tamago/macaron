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
- (void)viewDidLoad {
	%orig;
	[[[self dockView] backgroundView].layer setMasksToBounds:YES]; //backgroundViewのサブビューを自身に合わせて表示

	self.dockImageView = [[UIImageView alloc] init];
	[self.dockImageView setImage:[GcImagePickerUtils imageFromDefaults:@"com.misakateam.macaron" withKey:@"kDockImage"]];
	[self.dockImageView setContentMode:UIViewContentModeScaleAspectFill]; // アスペクトを維持したままViewに全体表示
	[self.dockImageView setClipsToBounds:YES]; // 親のViewに合わせて表示
	[self.dockImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight]; //自動で親のViewのサイズにレイアウトする。
	[[self dockView].backgroundView addSubview:self.dockImageView]; // backgroundViewのサブビューにdockImageViewを追加する
}
%end
%end

static void loadPreferences() {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	enabled = ([defaults objectForKey:@"kEnabled" inDomain:@"com.misakateam.macaron"] != nil) ? [[defaults objectForKey:@"kEnabled" inDomain:@"com.misakateam.macaron"] boolValue] : NO;
}

%ctor {
	loadPreferences();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, (CFStringRef)@"com.misakateam.macaron/ReloadPrefs", NULL, CFNotificationSuspensionBehaviorCoalesce);
    if (enabled) %init(Tweak);
}
