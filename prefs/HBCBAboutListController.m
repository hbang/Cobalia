#import "HBCBAboutListController.h"

@implementation HBCBAboutListController

#pragma mark - PSListController

- (instancetype)init {
	self = [super init];

	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"About" target:self] retain];
	}

	return self;
}

@end
