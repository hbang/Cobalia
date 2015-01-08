#define COBALIA_TWEAK_XM

#import "Global.h"
#import "HBCBToggleContainer.h"
#import "HBCBAppSwitcherTogglesDataSource.h"
#import <Cephei/HBPreferences.h>
#import <SpringBoard/SBAppSwitcherPeopleViewController.h>
#import <SpringBoard/SBAppSwitcherPeopleScrollView.h>

@class SBAppSwitcherPeopleScrollView, SBScrollViewItemWrapper;

HBPreferences *preferences;

%hook SBAppSwitcherPeopleViewController

- (void)switcherWillBePresented:(BOOL)animated {
	if ([preferences boolForKey:kHBCBPreferencesEnabledKey]) {
		if (![self.activeDataSource isKindOfClass:HBCBAppSwitcherTogglesDataSource.class]) {
			self.activeDataSource = [[HBCBAppSwitcherTogglesDataSource alloc] init];
			[self dataSourceChanged:self.activeDataSource];
		}
	} else if ([self.activeDataSource isKindOfClass:HBCBAppSwitcherTogglesDataSource.class]) {
		self.activeDataSource = nil;
		[self _configureDataSourceIfNecessaryAndPossible];
	}

	%orig;
}

- (UIView *)peopleScrollView:(SBAppSwitcherPeopleScrollView *)peopleScrollView viewForItem:(SBScrollViewItemWrapper *)item {
	if (![self.activeDataSource isKindOfClass:HBCBAppSwitcherTogglesDataSource.class]) {
		return %orig;
	}

	HBCBToggleContainer *toggleContainer = [[[HBCBToggleContainer alloc] initWithFrame:CGRectZero peopleController:self] autorelease];
	toggleContainer.itemWrapper = item;
	toggleContainer.legibilitySettings = self.legibilitySettings;
	return toggleContainer;
}

%end

%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:kHBCBPreferencesDomain];
	[preferences registerDefaults:@{
		kHBCBPreferencesEnabledKey: @YES,
		kHBCBPreferencesSwitchesKey: IS_IPAD
			? @[ @"com.a3tweaks.switch.airplane-mode", @"com.a3tweaks.switch.wifi", @"com.a3tweaks.switch.do-not-disturb", @"com.a3tweaks.switch.rotation-lock", @"com.a3tweaks.switch.respring" ]
			: @[ @"com.a3tweaks.switch.airplane-mode", @"com.a3tweaks.switch.wifi", @"com.a3tweaks.switch.do-not-disturb", @"com.a3tweaks.switch.rotation-lock", @"com.a3tweaks.switch.vibration", @"com.a3tweaks.switch.respring", @"com.a3tweaks.switch.flashlight" ],
		kHBCBPreferencesSectionLabelKey: @YES,
		kHBCBPreferencesSwitchLabelsKey: @NO
	}];

	%init;
}
