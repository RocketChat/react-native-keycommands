#import "RCTKeyCommandsHandler.h"

#import <UIKit/UIKit.h>

#import <React/RCTDefines.h>
#import <React/RCTUtils.h>

@interface RCTKeyCommandHandler : NSObject <NSCopying>

@property (nonatomic, strong) UIKeyCommand *keyCommandHandler;
@property (nonatomic, copy) void (^blockHandler)(UIKeyCommand *);

@end

@implementation RCTKeyCommandHandler

- (instancetype)initWithKeyCommand:(UIKeyCommand *)keyCommandHandler
                             block:(void (^)(UIKeyCommand *))blockHandler
{
  if ((self = [super init])) {
    _keyCommandHandler = keyCommandHandler;
    _blockHandler = blockHandler;
  }
  return self;
}

RCT_NOT_IMPLEMENTED(- (instancetype)init)

- (id)copyWithZone:(__unused NSZone *)zone
{
  return self;
}

- (NSUInteger)hash
{
  return _keyCommandHandler.input.hash ^ _keyCommandHandler.modifierFlags;
}

- (BOOL)isEqual:(RCTKeyCommandHandler *)object
{
  if (![object isKindOfClass:[RCTKeyCommandHandler class]]) {
    return NO;
  }
  return [self matchesInput:object.keyCommandHandler.input
                      flags:object.keyCommandHandler.modifierFlags];
}

- (BOOL)matchesInput:(NSString *)input flags:(UIKeyModifierFlags)flags
{
  return [_keyCommandHandler.input isEqual:input] && _keyCommandHandler.modifierFlags == flags;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"<%@:%p input=\"%@\" flags=%lld hasBlock=%@>",
          [self class], self, _keyCommandHandler.input, (long long)_keyCommandHandler.modifierFlags,
          _blockHandler ? @"YES" : @"NO"];
}

@end

@interface RCTKeyCommandsHandler ()

@property (nonatomic, strong) NSMutableSet<RCTKeyCommandHandler *> *commandsHandler;

@end

@implementation UIResponder (RCTKeyCommandsHandler)

+ (UIResponder *)RCT_getFirstResponder:(UIResponder *)view
{
  UIResponder *firstResponder = nil;

  if (view.isFirstResponder) {
    return view;
  } else if ([view isKindOfClass:[UIViewController class]]) {
    if ([(UIViewController *)view parentViewController]) {
      firstResponder = [UIResponder RCT_getFirstResponder: [(UIViewController *)view parentViewController]];
    }
    return firstResponder ? firstResponder : [UIResponder RCT_getFirstResponder: [(UIViewController *)view view]];
  } else if ([view isKindOfClass:[UIView class]]) {
    for (UIView *subview in [(UIView *)view subviews]) {
      firstResponder = [UIResponder RCT_getFirstResponder: subview];
      if (firstResponder) {
        return firstResponder;
      }
    }
  }

  return firstResponder;
}

- (NSArray<UIKeyCommand *> *)RCT_keyCommandsHandler
{
  NSSet<RCTKeyCommandHandler *> *commands = [RCTKeyCommandsHandler sharedInstance].commandsHandler;
  return [[commands valueForKeyPath:@"keyCommand"] allObjects];
}

/**
 * Single Press Key Command Response
 * Command + KeyEvent (Command + R/D, etc.)
 */
- (void)RCT_handleKeyCommand:(UIKeyCommand *)key
{
  // NOTE: throttle the key handler because on iOS 9 the handleKeyCommand:
  // method gets called repeatedly if the command key is held down.
  static NSTimeInterval lastCommand = 0;
  if (CACurrentMediaTime() - lastCommand > 0.5) {
    for (RCTKeyCommandHandler *command in [RCTKeyCommandsHandler sharedInstance].commandsHandler) {
      if ([command.keyCommandHandler.input isEqualToString:key.input] &&
          command.keyCommandHandler.modifierFlags == key.modifierFlags) {
        if (command.blockHandler) {
          command.blockHandler(key);
          lastCommand = CACurrentMediaTime();
        }
      }
    }
  }
}

@end

@implementation RCTKeyCommandsHandler

+ (void)initialize
{
  RCTSwapInstanceMethods([UIResponder class],
                         @selector(keyCommandsHandler),
                         @selector(RCT_keyCommandsHandler));
}

+ (instancetype)sharedInstance
{
  static RCTKeyCommandsHandler *sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [self new];
  });

  return sharedInstance;
}

- (instancetype)init
{
  if ((self = [super init])) {
    _commandsHandler = [NSMutableSet new];
  }
  return self;
}

- (void)registerKeyCommand:(NSString *)input
                      modifierFlags:(UIKeyModifierFlags)flags
               discoverabilityTitle:(NSString *)discoverabilityTitle
                             action:(void (^)(UIKeyCommand *))block
{
  RCTAssertMainQueue();

  UIKeyCommand *command = [UIKeyCommand keyCommandWithInput:input
                                              modifierFlags:flags
                                                     action:@selector(RCT_handleKeyCommand:)
                                       discoverabilityTitle:discoverabilityTitle];

  RCTKeyCommandHandler *keyCommand = [[RCTKeyCommandHandler alloc] initWithKeyCommand:command block:block];
  [_commandsHandler removeObject:keyCommand];
  [_commandsHandler addObject:keyCommand];
}

@end
