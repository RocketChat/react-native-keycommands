#import <UIKit/UIKit.h>

@interface RCTKeyCommandsHandler : NSObject

+ (instancetype)sharedInstance;

/**
 * Register a single-press keyboard command.
 */
- (void)registerKeyCommand:(NSString *)input
                      modifierFlags:(UIKeyModifierFlags)flags
               discoverabilityTitle:(NSString *)discoverabilityTitle
                             action:(void (^)(UIKeyCommand *))block;

@end
