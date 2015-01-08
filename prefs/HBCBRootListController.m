#import "HBCBRootListController.h"

@implementation HBCBRootListController

#pragma mark - Constants

+ (NSString *)hb_shareText {
	return [NSString stringWithFormat:@"I’m using Cobalia to quickly access toggles from my %@ app switcher!", [UIDevice currentDevice].localizedModel];
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"https://www.hbang.ws/tweaks/cobalia"];
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithWhite:74.f / 255.f alpha:1];
}

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

@end
