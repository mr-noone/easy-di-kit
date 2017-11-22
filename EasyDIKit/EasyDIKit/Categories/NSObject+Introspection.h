//
//  NSObject+Introspection.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 21.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Introspection)

+ (nullable Class)classOfProperty:(nonnull NSString *)propertyName;

@end
