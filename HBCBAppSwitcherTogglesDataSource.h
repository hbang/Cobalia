#import <SpringBoard/SBAppSwitcherPeopleDataSource.h>

@interface HBCBAppSwitcherTogglesDataSource : NSObject <SBAppSwitcherPeopleDataSource>

@property (nonatomic, assign) id<SBAppSwitcherPeopleDataSourceConsumer> consumer;
@property (nonatomic, retain) NSArray *switchIDs;

@end
