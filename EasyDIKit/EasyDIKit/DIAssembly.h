//
//  DIAssembly.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DIInjection;

typedef void(^DIAssemblyInjections)(DIInjection * _Nonnull injections);

@interface DIAssembly : NSObject

+ (nonnull instancetype)assembly;
+ (nonnull instancetype)assemblyWithConfiguration:(nullable DIAssemblyInjections)configuration;

@end
