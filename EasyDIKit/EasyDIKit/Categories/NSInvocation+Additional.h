//
//  NSInvocation+Additional.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 17.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (Additional)

+ (nullable id)invokeWithTarget:(nonnull id)target
                       selector:(nonnull SEL)selector
                     parameters:(nullable NSArray *)parameters;

@end
