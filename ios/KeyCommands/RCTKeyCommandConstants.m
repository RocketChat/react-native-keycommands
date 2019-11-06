#import <UIKit/UIKit.h>
#import "RCTKeyCommandConstants.h"

@implementation RCTKeyCommandConstants

RCT_EXPORT_MODULE();

- (NSDictionary *)constantsToExport {
    return @{
         @"keyModifierShift": @(UIKeyModifierAlphaShift),
         @"keyModifierControl": @(UIKeyModifierControl),
         @"keyModifierAlternate": @(UIKeyModifierAlternate),
         @"keyModifierCommand": @(UIKeyModifierCommand),
         @"keyModifierNumericPad": @(UIKeyModifierNumericPad),
         @"keyInputUpArrow": UIKeyInputUpArrow,
         @"keyInputDownArrow": UIKeyInputDownArrow,
         @"keyInputLeftArrow": UIKeyInputLeftArrow,
         @"keyInputRightArrow": UIKeyInputRightArrow,
         @"keyInputEscape": UIKeyInputEscape
    };
}

@end
