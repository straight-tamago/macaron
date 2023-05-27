#import <Preferences/Preferences.h>
#import <Preferences/PSSpecifier.h>
#import <spawn.h>

@interface MacaronRootListController : PSListController
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIBarButtonItem *respringButton;
- (void)respring:(id)sender;
- (void)openGithub;
- (void)openPaypal;
@end