//
//  DIInitializer+Private.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <EasyDIKit/EasyDIKit.h>

@interface DIInitializer ()

- (nonnull instancetype)initWithClass:(nonnull Class)aClass;

- (nullable id)perform;

@end
