//
//  DIAssembly.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIAssembly.h"
#import "DIFactory.h"
#import "DIInjection.h"

#import <objc/runtime.h>
#import "NSObject+Introspection.h"

@implementation DIAssembly

#pragma mark - Factories

+ (instancetype)assembly {
    DIAssemblyInjections configuration = ^(DIInjection *injections) {
        [self autoInjectWithInjection:injections];
    };
    
    return [self assemblyWithConfiguration:configuration];
}

+ (instancetype)assemblyWithConfiguration:(DIAssemblyInjections)configuration {
    DIFactoryInjections injections = ^(DIInjection *injections) {
        if (configuration) {
            configuration(injections);
        }
    };
    
    return [DIFactory singletonOfClass:self initializer:nil injections:injections];
}

#pragma mark - Private

+ (void)autoInjectWithInjection:(DIInjection *)injection {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        
        Class class = [self classOfProperty:[NSString stringWithUTF8String:propertyName]];
        Class superclass = class_getSuperclass(class);
        
        if (superclass == DIAssembly.class) {
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            [injection injectProperty:NSSelectorFromString(propertyName) with:[class assembly]];
        }
        
    }
    
    free(properties);
}

@end
