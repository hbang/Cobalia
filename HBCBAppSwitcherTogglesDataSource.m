#import "Global.h"
#import "HBCBAppSwitcherTogglesDataSource.h"
#import "HBCBAppSwitcherToggleItem.h"

@implementation HBCBAppSwitcherTogglesDataSource

- (NSUInteger)numberOfSections {
	return 1;
}

- (NSUInteger)numberOfContactsInSection:(NSUInteger)section {
	return _switchIDs.count;
}

- (id)contactItemForIndexPath:(NSIndexPath *)indexPath {
	return [[HBCBAppSwitcherToggleItem alloc] initWithSwitchID:_switchIDs[indexPath.row]];
}

- (NSString *)optionalEmptyPlaceholderStringForSection:(NSUInteger)section {
	return @"No Toggles";
}

- (NSString *)titleForSection:(NSUInteger)section {
	return [userDefaults boolForKey:kHBCBPreferencesSectionLabelKey] ? @"Toggles" : @"";
}

- (void)updateIfNecessary {
	_switchIDs = [userDefaults objectForKey:kHBCBPreferencesSwitchesKey];
}

- (void)cachedMonogramImageForPersonID:(NSInteger)personID ofSize:(CGFloat)size generatingIfNecessaryWithResult:(id)result {}
- (id)existingCachedMonogramImageForPersonID:(NSInteger)personID ofSize:(CGFloat)size outIsMask:(BOOL *)mask { return nil; }
- (void)purgeCaches {}
- (id)silhouetteMonogramOfSize:(CGFloat)size { return nil; }

@end
