//
//  DIFactory.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 16.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DIInitializer;
@class DIInjection;

typedef void(^DIFactoryInitializer)(DIInitializer * _Nonnull initializer);
typedef void(^DIFactoryInjections)(DIInjection * _Nonnull injections);

@interface DIFactory : NSObject

+ (nullable id)instanceOfClass:(nonnull Class)aClass;
+ (nullable id)instanceOfClass:(nonnull Class)aClass
                   initializer:(nullable DIFactoryInitializer)initializer
                    injections:(nullable DIFactoryInjections)injections;

+ (nullable id)singletonOfClass:(nonnull Class)aClass;
+ (nullable id)singletonOfClass:(nonnull Class)aClass
                    initializer:(nullable DIFactoryInitializer)initializer
                     injections:(nullable DIFactoryInjections)injections;

@end
