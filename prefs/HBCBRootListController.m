#import "HBCBRootListController.h"

@implementation HBCBRootListController

#pragma mark - Constants

+ (NSString *)hb_shareText {
	NSString *formatString = NSLocalizedStringFromTableInBundle(@"SHARE_TEXT", @"Root", [NSBundle bundleForClass:self.class], @"Default text for sharing the tweak. %@ is the device type (ie, iPhone).");
	return [NSString stringWithFormat:formatString, [UIDevice currentDevice].localizedModel];
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"https://www.hbang.ws/tweaks/cobalia/"];
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithWhite:74.f / 255.f alpha:1];
}

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

@end
