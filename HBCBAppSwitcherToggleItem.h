@interface HBCBAppSwitcherToggleItem : NSObject <NSCopying>

- (instancetype)initWithSwitchID:(NSString *)switchID;

@property (nonatomic, retain) NSString *switchID;

@end
