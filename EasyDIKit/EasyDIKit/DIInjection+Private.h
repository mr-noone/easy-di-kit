//
//  DIInjection+Private.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIInjection.h"

@interface DIInjection ()

- (nonnull instancetype)initWithTarget:(nonnull id)target;

- (void)perform;

@end
