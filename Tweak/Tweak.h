#import <UIKit/UIKit.h>
#import <Foundation/NSUserDefaults.h>
#import "Classes/FLAnimatedImage.h"

@interface SBFloatingDockView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@end

@interface SBFloatingDockViewController : UIViewController
@property (nonatomic, retain) FLAnimatedImageView *dockImageView;
@property (nonatomic, strong, readwrite) SBFloatingDockView *dockView;
@end

@interface NSUserDefaults (Private)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end
