#import <UIKit/UIKit.h>
#import <GcUniversal/GcImagePickerUtils.h>
#import <Cephei/HBPreferences.h>
#import "./Classes/FLAnimatedImage.h"

@interface SBDockView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, retain) FLAnimatedImageView *dockImageView;
@property (nonatomic, retain) UIVisualEffectView *visualEffectView;
@end

@interface SBFloatingDockView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@end

@interface SBFloatingDockViewController : UIViewController
@property (nonatomic, retain) FLAnimatedImageView *dockImageView;
@property (nonatomic, strong, readwrite) SBFloatingDockView *dockView;
@property (nonatomic, retain) UIVisualEffectView *visualEffectView;
@end