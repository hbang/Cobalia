#import "HBCBAppSwitcherToggleView.h"
#import <AddressBookUI/ABMonogrammer.h>

static const char* kHBCBAppSwitcherToggleViewIconViewIdentifier;

%subclass HBCBAppSwitcherToggleView : SBAppSwitcherPeopleContactView

- (id)initWithFrame:(CGRect)frame forMonogramSize:(CGFloat)monogramSize compact:(BOOL)compact {
	self = %orig;

	if (self) {
		static UIImage *KnockoutMask = nil;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			ABMonogrammer *monogrammer = [[[ABMonogrammer alloc] initWithStyle:ABMonogrammerStyleLightGraySemitransparent diameter:monogramSize] autorelease];
			[monogrammer monogramsAsFlatImages];
			KnockoutMask = [monogrammer _copyMonogramWithKnockoutMask];
		});

		self.imageRenderingMode = UIImageRenderingModeAlwaysTemplate;
		self.image = KnockoutMask;

		UIView *wallpaperEffectView = MSHookIvar<UIView *>(self, "_wallpaperEffectView");

		UIImageView *iconView = [[UIImageView alloc] initWithFrame:wallpaperEffectView.bounds];
		iconView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		iconView.contentMode = UIViewContentModeCenter;
		[wallpaperEffectView addSubview:iconView];

		self.iconView = iconView;
	}

	return self;
}

%new - (UIImageView *)iconView {
	return objc_getAssociatedObject(self, &kHBCBAppSwitcherToggleViewIconViewIdentifier);
}

%new - (void)setIconView:(UIImageView *)iconView {
	objc_setAssociatedObject(self, &kHBCBAppSwitcherToggleViewIconViewIdentifier, iconView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dealloc {
	[self.iconView release];
	%orig;
}

%end
