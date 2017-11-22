//
//  NSObject+Introspection.m
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 21.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "NSObject+Introspection.h"
#import <objc/runtime.h>

@implementation NSObject (Introspection)

+ (Class)classOfProperty:(NSString *)propertyName {
    objc_property_t property = class_getProperty(self.class, propertyName.UTF8String);
    char *type = property_copyAttributeValue(property, "T");
    
    NSRegularExpression *classNameRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=@\")[[:word:]]+"
                                                                                    options:0
                                                                                      error:nil];
    NSArray<NSTextCheckingResult *> *matches = [classNameRegex matchesInString:[NSString stringWithUTF8String:type]
                                                                       options:0
                                                                         range:NSMakeRange(0, strlen(type))];
    
    if (matches.count != 1) {
        return nil;
    }
    
    NSRange range = matches.firstObject.range;
    
    char className[range.length + 1];
    strncpy(className, &type[range.location], range.length);
    className[matches.firstObject.range.length] = '\0';
    
    free(type);
    
    return objc_getClass(className);
}

@end
