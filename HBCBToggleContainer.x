#import "Global.h"
#import "HBCBToggleContainer.h"
#import "HBCBAppSwitcherToggleItem.h"
#import "HBCBAppSwitcherToggleView.h"
#import <Flipswitch/FSSwitchPanel.h>

@implementation HBCBToggleContainer {
	SBScrollViewItemWrapper *_itemWrapper;
}

- (instancetype)initWithFrame:(CGRect)frame peopleController:(SBAppSwitcherPeopleViewController *)peopleController {
	self = [super initWithFrame:frame];

	if (self) {
		self.backgroundColor = [UIColor clearColor];

		_peopleController = peopleController;

		_contactView = [[%c(HBCBAppSwitcherToggleView) alloc] initWithFrame:self.bounds forMonogramSize:peopleController.monogramSize compact:peopleController.useVerticallyCompactLayoutSize];
		_contactView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[_contactView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedGestureRecognizerOnContactContainer:)] autorelease]];
		[_contactView addGestureRecognizer:[[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(heldGestureRecognizerOnContactContainer:)] autorelease]];
		[self addSubview:_contactView];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchStateDidChange:) name:FSSwitchPanelSwitchStateChangedNotification object:nil];
	}

	return self;
}

- (NSString *)switchID {
	return ((HBCBAppSwitcherToggleItem *)_itemWrapper.item).switchID;
}

- (SBScrollViewItemWrapper *)itemWrapper {
	return _itemWrapper;
}

- (void)setItemWrapper:(SBScrollViewItemWrapper *)itemWrapper {
	_itemWrapper = [itemWrapper retain];

	NSString *switchName = [[FSSwitchPanel sharedPanel] titleForSwitchIdentifier:self.switchID];
	_contactView.title = [preferences boolForKey:kHBCBPreferencesSwitchLabelsKey] ? switchName : @"";
	_contactView.accessibilityLabel = switchName;

	[self updateState];
}

- (id)legibilitySettings {
	return _contactView.legibilitySettings;
}

- (void)setLegibilitySettings:(id)legibilitySettings {
	_contactView.legibilitySettings = legibilitySettings;
}

- (void)tappedGestureRecognizerOnContactContainer:(UITapGestureRecognizer *)gestureRecognizer {
	[[FSSwitchPanel sharedPanel] applyActionForSwitchIdentifier:self.switchID];
}

- (void)heldGestureRecognizerOnContactContainer:(UILongPressGestureRecognizer *)gestureRecognizer {
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		[[FSSwitchPanel sharedPanel] applyAlternateActionForSwitchIdentifier:self.switchID];
	}
}

- (void)updateState {
	static NSBundle *TemplateBundle = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		TemplateBundle = [[NSBundle bundleWithPath:@"/Library/Application Support/CobaliaFlipswitch.bundle"] retain];
	});

	_contactView.alpha = [[FSSwitchPanel sharedPanel] stateForSwitchIdentifier:self.switchID] == FSSwitchStateOff ? 0.6f : 1; // can't do better than this with fake blur views :(
	_contactView.iconView.image = [[FSSwitchPanel sharedPanel] imageOfSwitchState:[[FSSwitchPanel sharedPanel] stateForSwitchIdentifier:self.switchID] controlState:UIControlStateNormal forSwitchIdentifier:self.switchID usingTemplate:TemplateBundle];
}

- (void)switchStateDidChange:(NSNotification *)notification {
	if ([notification.userInfo[FSSwitchPanelSwitchIdentifierKey] isEqualToString:self.switchID]) {
		[self updateState];
	}
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[_itemWrapper release];
	[_contactView release];

	[super dealloc];
}

@end
