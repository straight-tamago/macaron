#import <UIKit/UIKit.h>
#import <Foundation/NSUserDefaults.h>

@interface SBFloatingDockViewController : UIViewController
@property (nonatomic, strong, readwrite) SBFloatingDockView *dockView;
@end

@interface SBFloatingDockView : UIView
@property (nonatomic, retain) UIImageView *dockImageView;
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@end

@interface NSUserDefaults (Private)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end
