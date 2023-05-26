#import "MacaronRootListController.h"

@implementation MacaronRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring:)];
    self.respringButton.tintColor = [UIColor secondaryLabelColor];
    self.navigationItem.rightBarButtonItem = self.respringButton;

	self.navigationItem.titleView = [UIView new];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Tweak";
	self.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    [self.navigationItem.titleView addSubview:self.titleLabel];

	[self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.titleLabel.centerXAnchor constraintEqualToAnchor:self.navigationItem.titleView.centerXAnchor].active = YES;
	[self.titleLabel.centerYAnchor constraintEqualToAnchor:self.navigationItem.titleView.centerYAnchor].active = YES;

    self.iconView = [[UIImageView alloc] init];
	self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/Macaron.bundle/icon.png"];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
	self.iconView.alpha = 0.0;
    [self.navigationItem.titleView addSubview:self.iconView];

	[self.iconView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.iconView.centerXAnchor constraintEqualToAnchor:self.navigationItem.titleView.centerXAnchor].active = YES;
	[self.iconView.centerYAnchor constraintEqualToAnchor:self.navigationItem.titleView.centerYAnchor].active = YES;

	[self.titleLabel sizeToFit];
	[self.iconView sizeToFit];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat const offsetY = scrollView.contentOffset.y;
  if (offsetY > 100) {
    [UIView animateWithDuration:0.2 animations:^{
		self.iconView.alpha = 1.0;
		self.titleLabel.alpha = 0.0;
	}];
  } else {
    [UIView animateWithDuration:0.2 animations:^{
		self.iconView.alpha = 0.0;
		self.titleLabel.alpha = 1.0;
	}];
  }
}

- (void)respring:(id)sender {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.misakateam.macaron/respring"), NULL, NULL, YES);
}

- (void)openGithub {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://sugiuta.github.io/repo/"]];
}

- (void)openPaypal {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/sugiuta1203"]];
}

- (UITableViewStyle)tableViewStyle {
	return UITableViewStyleInsetGrouped;
}

@end
