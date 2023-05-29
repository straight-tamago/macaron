#import <UIKit/UIKit.h>
#import <GcUniversal/GcImagePickerUtils.h>
#import <Cephei/HBPreferences.h>
#import "../Classes/FLAnimatedImage.h"

@interface SBFloatingDockView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@end

@interface SBFloatingDockViewController : UIViewController
@property (nonatomic, retain) FLAnimatedImageView *dockImageView;
@property (nonatomic, strong, readwrite) SBFloatingDockView *dockView;
@end