#import "HBCBAppSwitcherToggleItem.h"

@implementation HBCBAppSwitcherToggleItem

- (instancetype)initWithSwitchID:(NSString *)switchID {
	self = [super init];

	if (self) {
		_switchID = [switchID copy];
	}

	return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
	return [[self.class allocWithZone:zone] initWithSwitchID:[_switchID copyWithZone:zone]];
}

@end
