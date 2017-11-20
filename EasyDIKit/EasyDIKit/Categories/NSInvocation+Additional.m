//
//  NSInvocation+Additional.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 17.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "NSInvocation+Additional.h"

@implementation NSInvocation (Additional)

+ (id)invokeWithTarget:(id)target selector:(SEL)selector parameters:(NSArray *)parameters {
    if (target == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'target' dont be nil"];
    }
    
    if (selector == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Property 'selector' dont be nil"];
    }
    
    if ([target respondsToSelector:selector] == NO) {
        NSString *format = @"Unrecognized selector '%@' for class '%@'";
        NSString *reason = [NSString stringWithFormat:format, NSStringFromSelector(selector), NSStringFromClass([target class])];
        [NSException raise:DIUnrecognizedSelectorException format:@"%@", reason];
    }
    
    NSMethodSignature *signature;
    if ([[target class] instancesRespondToSelector:selector]) {
        signature = [[target class] instanceMethodSignatureForSelector:selector];
    } else {
        signature = [[target class] methodSignatureForSelector:selector];
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;
    invocation.target = target;
    
    for (int i = 0; i < parameters.count; i++) {
        id param = parameters[i];
        if ([param isKindOfClass:NSNull.class] == NO) {
            [invocation setArgument:&param atIndex:i + 2];
        }
    }
    
    void *returnValue;
    
    [invocation invoke];
    [invocation getReturnValue:&returnValue];
    
    return (__bridge id)returnValue;
}

@end
