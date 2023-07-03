#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <CepheiPrefs/CepheiPrefs.h>
#import <spawn.h>
#import <rootless.h>

@interface MacaronRootListController : HBRootListController
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIStackView *stackView;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *versionLabel;
@property (nonatomic, retain) UIBarButtonItem *respringButton;
- (void)respring:(id)sender;
@end