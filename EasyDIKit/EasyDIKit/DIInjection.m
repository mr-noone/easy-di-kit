//
//  DIInjection.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIInjection+Private.h"
#import "DIMethod+Private.h"

@interface DIInjection ()

@property (strong, nonatomic) id target;
@property (strong, nonatomic) NSMutableDictionary *propertyInjections;
@property (strong, nonatomic) NSMutableArray *methodInjections;

@end

@implementation DIInjection

#pragma mark - Init

- (instancetype)initWithTarget:(id)target {
    if (target == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'target' dont be nil"];
    }
    
    self = [super init];
    
    _target = target;
    _propertyInjections = [NSMutableDictionary dictionary];
    _methodInjections = [NSMutableArray array];
    
    return self;
}

#pragma mark - Public

- (void)injectProperty:(SEL)selector with:(id)value {
    if (value == nil) {
        [self.propertyInjections setObject:NSNull.null forKey:NSStringFromSelector(selector)];
    } else {
        [self.propertyInjections setObject:value forKey:NSStringFromSelector(selector)];
    }
}

- (void)injectMethod:(SEL)selector parameters:(DIInjectionParameters)parameters {
    if (parameters == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'parameters' dont be nil"];
    }
    
    DIMethod *method = [[DIMethod alloc] initWithTarget:self.target selector:selector];
    parameters(method);
    
    [self.methodInjections addObject:method];
}

#pragma mark - Private

- (void)perform {
    [self.propertyInjections enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [self.target setValue:obj forKey:key];
    }];
    
    [self.methodInjections enumerateObjectsUsingBlock:^(DIMethod *method, NSUInteger idx, BOOL *stop) {
        [method perform];
    }];
}

@end
