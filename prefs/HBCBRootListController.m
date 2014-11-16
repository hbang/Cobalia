#import "HBCBRootListController.h"

@implementation HBCBRootListController

#pragma mark - Constants

+ (NSString *)hb_shareText {
	return [NSString stringWithFormat:@"I’m using Cobalia to quickly access settings from my %@ app switcher!", [UIDevice currentDevice].localizedModel];
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"https://cydia.saurik.com/package/ws.hbang.cobalia"];
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithWhite:74.f / 255.f alpha:1];
}

#pragma mark - UIViewController

- (instancetype)init {
	self = [super init];

	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return self;
}

@end
