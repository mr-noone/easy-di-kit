//
//  DIInitializer.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 16.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIInitializer : NSObject

@property (assign, nonatomic, nonnull) SEL selector;

- (void)injectParameter:(nullable id)parameter;

@end
