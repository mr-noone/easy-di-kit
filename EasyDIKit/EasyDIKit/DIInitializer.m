//
//  DIInitializer.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 16.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIInitializer+Private.h"
#import "DIMethod+Private.h"
#import "NSInvocation+Additional.h"

@interface DIInitializer ()

@property (strong, nonatomic) DIMethod *method;
@property (strong, nonatomic) Class aClass;

@end

@implementation DIInitializer

#pragma mark - Init

- (instancetype)initWithClass:(Class)aClass {
    if (aClass == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'class' dont be nil"];
    }
    
    self = [super init];
    
    _aClass = aClass;
    _selector = @selector(new);
    _method = [[DIMethod alloc] initWithTarget:_aClass selector:_selector];
    
    return self;
}

#pragma mark - Public

- (void)setSelector:(SEL)selector {
    if (selector == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Property 'selector' dont be nil"];
    }
    
    _selector = selector;
    
    id target = [self.aClass instancesRespondToSelector:_selector] ? [self.aClass alloc] : self.aClass;
    
    self.method.target = target;
    self.method.selector = selector;
}

- (void)injectParameter:(id)parameter {
    [self.method injectParameter:parameter];
}

- (id)perform {
    return [self.method perform];
}

@end
