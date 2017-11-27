//
//  DIMethod.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIMethod+Private.h"
#import "NSInvocation+Additional.h"

@interface DIMethod ()

@property (strong, nonatomic) NSMutableArray *parameters;

@end

@implementation DIMethod

#pragma mark - Init

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    if (target == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'target' dont be nil"];
    }
    
    if (selector == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'selector' dont be nil"];
    }
    
    self = [super init];
    
    _target = target;
    _parameters = [NSMutableArray array];
    _selector = selector;
    
    return self;
}

#pragma mark - Public

- (void)injectParameter:(id)parameter {
    if (parameter == nil) {
        [self.parameters addObject:NSNull.null];
    } else {
        [self.parameters addObject:parameter];
    }
}

- (id)perform {
    return [NSInvocation invokeWithTarget:self.target selector:self.selector parameters:self.parameters];
}

@end
