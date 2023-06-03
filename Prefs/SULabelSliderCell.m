#import <Preferences/PSSliderTableCell.h>
#import "SULabelSliderCell.h"

@implementation SULabelSliderCell {
	UIStackView *_sliderStackView;
	UILabel *_sliderLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {

	self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

	if (self) {

        [specifier setProperty:@56 forKey:PSTableCellHeightKey];

		NSBundle *bundle = [specifier.target bundle];
		NSString *label = [specifier propertyForKey:PSTitleKey];
		NSString *localizationTable = [specifier propertyForKey:@"localizationTable"];

		_sliderLabel = [[UILabel alloc] init];
		_sliderLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
		_sliderLabel.text = [bundle localizedStringForKey:label value:label table:localizationTable];
		_sliderLabel.textColor = [UIColor labelColor];
		_sliderLabel.translatesAutoresizingMaskIntoConstraints = NO;

		_sliderStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_sliderLabel, self.control]];
		_sliderStackView.alignment = UIStackViewAlignmentCenter;
		_sliderStackView.axis = UILayoutConstraintAxisHorizontal;
		_sliderStackView.distribution = UIStackViewDistributionEqualCentering;
		_sliderStackView.spacing = 5;
		_sliderStackView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_sliderStackView];

		[NSLayoutConstraint activateConstraints:@[

		    [_sliderStackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:4],
            [_sliderStackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
            [_sliderStackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4],
            [_sliderStackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
            [self.control.leadingAnchor constraintEqualToAnchor:_sliderLabel.trailingAnchor constant:15],
            [self.control.trailingAnchor constraintEqualToAnchor:_sliderStackView.trailingAnchor],

		]];

	}

	return self;

}

@end