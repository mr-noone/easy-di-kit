//
//  DIFactory.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 16.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIFactory.h"

#import "DIInitializer+Private.h"
#import "DIInjection+Private.h"

@interface DIFactory ()

@property (class, nonatomic, readonly) NSMutableDictionary *singletons;

@end

@implementation DIFactory

#pragma mark - Factories

+ (id)instanceOfClass:(Class)aClass {
    return [self instanceOfClass:aClass initializer:nil injections:nil];
}

+ (id)instanceOfClass:(Class)aClass
          initializer:(DIFactoryInitializer)initializer
           injections:(DIFactoryInjections)injections {
    
    if (aClass == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'class' dont be nil"];
    }
    
    DIInitializer *init = [[DIInitializer alloc] initWithClass:aClass];
    if (initializer) {
        initializer(init);
    }
    
    id instance = [init perform];
    
    DIInjection *injection = [[DIInjection alloc] initWithTarget:instance];
    if (injections) {
        injections(injection);
    }
    
    [injection perform];
    
    return instance;
}

+ (id)singletonOfClass:(Class)aClass {
    return [self singletonOfClass:aClass initializer:nil injections:nil];
}

+ (id)singletonOfClass:(Class)aClass
           initializer:(DIFactoryInitializer)initializer
            injections:(DIFactoryInjections)injections {
    
    if (aClass == nil) {
        [NSException raise:DIInvalidArgumentException format:@"Parameter 'class' dont be nil"];
    }
    
    NSString *singletonName = NSStringFromClass(aClass);
    id singleton = [self.singletons objectForKey:singletonName];
    
    if (singleton == nil) {
        singleton = [self instanceOfClass:aClass
                              initializer:initializer
                               injections:injections];
        
        if (singleton != nil) {
            [self.singletons setObject:singleton forKey:singletonName];
        }
    }
    
    return singleton;
}

#pragma mark - Getters

+ (NSMutableDictionary *)singletons {
    static NSMutableDictionary *singletons;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletons = [NSMutableDictionary dictionary];
    });
    return singletons;
}

@end
