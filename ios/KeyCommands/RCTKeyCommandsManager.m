#import "RCTKeyCommandsManager.h"
#import "RCTKeyCommands.h"
#import "RCTLog.h"

@implementation RCTKeyCommandsManager

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"onKeyCommand"];
}

- (void)onKeyCommand:(UIKeyCommand *)keyCommand
{
  [self sendEventWithName:@"onKeyCommand" body:@{
        @"input": keyCommand.input,
        @"modifierFlags": [NSNumber numberWithInteger:keyCommand.modifierFlags]
    }];
}

RCT_EXPORT_METHOD(setKeyCommands:(NSArray *)json
                         resolve:(RCTPromiseResolveBlock)resolve
                          reject:(__unused RCTPromiseRejectBlock)reject) {
    NSArray<NSDictionary *> *commandsArray = json;
    for (NSDictionary *commandJSON in commandsArray) {
        NSString *input = commandJSON[@"input"];
        NSNumber *flags = commandJSON[@"modifierFlags"];
        NSString *discoverabilityTitle = commandJSON[@"discoverabilityTitle"];
        if (!flags) {
            flags = @0;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RCTKeyCommands sharedInstance]
                registerKeyCommand:input
                modifierFlags:[flags integerValue]
                discoverabilityTitle:discoverabilityTitle
                action:^(__unused UIKeyCommand *command) {
                    [self onKeyCommand:command];
                }];
        });
    }

    resolve([NSNull null]);
}

RCT_EXPORT_METHOD(deleteKeyCommands:(NSArray *)json
                           resolve:(RCTPromiseResolveBlock)resolve
                            reject:(__unused RCTPromiseRejectBlock)reject)
{
    NSArray<NSDictionary *> *commandsArray = json;
    for (NSDictionary *commandJSON in commandsArray) {
        NSString *input = commandJSON[@"input"];
        NSNumber *flags = commandJSON[@"modifierFlags"];
        if (!flags) {
            flags = @0;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RCTKeyCommands sharedInstance]
                unregisterKeyCommandWithInput:input
                modifierFlags:[flags integerValue]];
        });
    }

    resolve([NSNull null]);
}

@end
