#define COBALIA_TWEAK_XM

#import "Global.h"
#import "HBCBToggleContainer.h"
#import "HBCBAppSwitcherTogglesDataSource.h"
#import <SpringBoard/SBAppSwitcherPeopleViewController.h>
#import <SpringBoard/SBAppSwitcherPeopleScrollView.h>

@class SBAppSwitcherPeopleScrollView, SBScrollViewItemWrapper;

NSUserDefaults *userDefaults;

%hook SBAppSwitcherPeopleViewController

- (void)switcherWillBePresented:(BOOL)animated {
	if ([userDefaults boolForKey:kHBCBPreferencesEnabledKey]) {
		if (![self.activeDataSource isKindOfClass:HBCBAppSwitcherTogglesDataSource.class]) {
			self.activeDataSource = [[HBCBAppSwitcherTogglesDataSource alloc] init];
			[self dataSourceChanged:self.activeDataSource];
		}
	} else if ([self.activeDataSource isKindOfClass:HBCBAppSwitcherTogglesDataSource.class]) {
		self.activeDataSource = nil;
	}

	%orig;
}

- (UIView *)peopleScrollView:(SBAppSwitcherPeopleScrollView *)peopleScrollView viewForItem:(SBScrollViewItemWrapper *)item {
	if (![self.activeDataSource isKindOfClass:HBCBAppSwitcherTogglesDataSource.class]) {
		return %orig;
	}

	HBCBToggleContainer *toggleContainer = [[HBCBToggleContainer alloc] initWithFrame:CGRectZero peopleController:self];
	toggleContainer.itemWrapper = item;
	toggleContainer.legibilitySettings = self.legibilitySettings;
	return toggleContainer;
}

%end

void HBCBPreferencesChanged() {
	// flipswitch writes directly to the plist...
	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:[[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:kHBCBPreferencesDomain] stringByAppendingPathExtension:@"plist"]];

	if (preferences[kHBCBPreferencesSwitchesKey]) {
		[userDefaults setObject:preferences[kHBCBPreferencesSwitchesKey] forKey:kHBCBPreferencesSwitchesKey];
	}
}

%ctor {
	userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kHBCBPreferencesDomain];
	[userDefaults registerDefaults:@{
		kHBCBPreferencesEnabledKey: @YES,
		kHBCBPreferencesSwitchesKey: IS_IPAD
			? @[ @"com.a3tweaks.switch.airplane-mode", @"com.a3tweaks.switch.wifi", @"com.a3tweaks.switch.do-not-disturb", @"com.a3tweaks.switch.rotation-lock", @"com.a3tweaks.switch.respring" ]
			: @[ @"com.a3tweaks.switch.airplane-mode", @"com.a3tweaks.switch.wifi", @"com.a3tweaks.switch.do-not-disturb", @"com.a3tweaks.switch.rotation-lock", @"com.a3tweaks.switch.vibration", @"com.a3tweaks.switch.respring", @"com.a3tweaks.switch.flashlight" ],
		kHBCBPreferencesSectionLabelKey: @YES,
		kHBCBPreferencesSwitchLabelsKey: @YES
	}];

	%init;

	HBCBPreferencesChanged();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)HBCBPreferencesChanged, CFSTR("ws.hbang.cobalia/ReloadPrefs"), NULL, kNilOptions);
}
