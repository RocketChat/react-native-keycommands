#import "RCTKeyCommandsManager.h"
#import "RCTKeyCommandsView.h"

@implementation RCTKeyCommandsManager

RCT_EXPORT_MODULE();

RCT_EXPORT_VIEW_PROPERTY(onKeyCommand, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(keyCommands, NSArray<UIKeyCommand *>, RCTKeyCommandsView) {
    [view setKeyCommandsWithJSON:json];
}

- (UIView *)view {
    return [[RCTKeyCommandsView alloc] init];
}

@end
