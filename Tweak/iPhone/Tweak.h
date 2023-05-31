#import <UIKit/UIKit.h>
#import <GcUniversal/GcImagePickerUtils.h>
#import <Cephei/HBPreferences.h>
#import "../Classes/FLAnimatedImage.h"

@interface SBDockView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, retain) FLAnimatedImageView *dockImageView;
@property (nonatomic, retain) UIVisualEffectView *visualEffectView;
@end