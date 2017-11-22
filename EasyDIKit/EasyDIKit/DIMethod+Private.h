//
//  DIMethod+Private.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIMethod.h"

@interface DIMethod ()

@property (strong, nonatomic, nonnull) id target;
@property (assign, nonatomic, nonnull) SEL selector;

@end
