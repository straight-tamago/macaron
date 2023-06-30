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

    HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
	UIColor *defaultColor = [UIColor colorWithRed:109/255.0 green:174/255.0 blue:255/255.0 alpha:1.0];
	appearanceSettings.tintColor = defaultColor;
	appearanceSettings.navigationBarBackgroundColor = [UIColor clearColor];
	appearanceSettings.tableViewCellSeparatorColor = [UIColor clearColor];
	appearanceSettings.largeTitleStyle = 1;
	self.hb_appearanceSettings = appearanceSettings;

    self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring:)];
    self.respringButton.tintColor = [UIColor secondaryLabelColor];
    self.navigationItem.rightBarButtonItem = self.respringButton;

	self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
	[self.headerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

	self.stackView = [[UIStackView alloc] init];
	[self.stackView setAlpha:0.0];
    [self.stackView setAxis:UILayoutConstraintAxisHorizontal];
    [self.stackView setAlignment:UIStackViewAlignmentCenter];
    [self.stackView setDistribution:UIStackViewDistributionEqualSpacing];
    [self.headerView addSubview:self.stackView];

	[self.stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[NSLayoutConstraint activateConstraints:@[
		[self.stackView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
		[self.stackView.leftAnchor constraintEqualToAnchor:self.headerView.leftAnchor constant:30],
		[self.stackView.rightAnchor constraintEqualToAnchor:self.headerView.rightAnchor constant:-30],
		[self.stackView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
	]];

	self.iconView= [[UIImageView alloc] init];
    [self.iconView setFrame:CGRectMake(0, 0, 60, 60)];
	[self.iconView setImage:[UIImage imageWithContentsOfFile:ROOT_PATH_NS(@"/Library/PreferenceBundles/Macaron.bundle/icon.png")]];
    [self.iconView setContentMode:UIViewContentModeScaleAspectFit];
    [self.stackView addArrangedSubview:self.iconView];

	self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setText:@"Macaron"];
    [self.titleLabel setFont:[UIFont monospacedDigitSystemFontOfSize:40 weight:UIFontWeightBold]];
    [self.titleLabel setTextColor:[UIColor labelColor]];
	[self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.stackView addArrangedSubview:self.titleLabel];
	[self.titleLabel sizeToFit];

	self.versionLabel = [[UILabel alloc] init];
    [self.versionLabel setText:@"v1.0.1"];
    [self.versionLabel setFont:[UIFont monospacedDigitSystemFontOfSize:30 weight:UIFontWeightBold]];
    [self.versionLabel setTextColor:[UIColor secondaryLabelColor]];
	[self.versionLabel setTextAlignment:NSTextAlignmentCenter];
    [self.stackView addArrangedSubview:self.versionLabel];
	[self.versionLabel sizeToFit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        [self.stackView setAlpha:1.0];
    } completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)respring:(id)sender {
	// Rootlessだとkillallのディレクトリが違うので注意が必要。
    pid_t pid;
    const char* args[] = {"killall", "SpringBoard", NULL};
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/bin/killall"]) posix_spawn(&pid, "usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    else posix_spawn(&pid, "/var/jb/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

- (UITableViewStyle)tableViewStyle {
	return UITableViewStyleInsetGrouped;
}

@end
