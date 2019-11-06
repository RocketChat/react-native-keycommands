#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface RCTKeyCommandsView : UIView

@property (nullable, copy) RCTBubblingEventBlock onKeyCommand;

- (void) setKeyCommandsWithJSON:(id _Nullable)json;

@end
