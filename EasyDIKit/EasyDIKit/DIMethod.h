//
//  DIMethod.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIMethod : NSObject

- (nonnull instancetype)initWithTarget:(nonnull id)target
                              selector:(nonnull SEL)selector;

- (void)injectParameter:(nullable id)parameter;
- (nullable id)perform;

@end
