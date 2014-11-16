#import <SpringBoard/SBAppSwitcherPeopleViewController.h>
#import <SpringBoard/SBScrollViewItemWrapper.h>

@class HBCBAppSwitcherToggleView;

@interface HBCBToggleContainer : UIView

@property (nonatomic, copy) SBScrollViewItemWrapper *itemWrapper;
@property (nonatomic, retain) SBAppSwitcherPeopleViewController *peopleController;
@property (nonatomic, retain) HBCBAppSwitcherToggleView *contactView;
@property (nonatomic, retain) id legibilitySettings;

- (instancetype)initWithFrame:(CGRect)frame peopleController:(SBAppSwitcherPeopleViewController *)peopleController;

@end
