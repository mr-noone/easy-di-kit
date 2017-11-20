//
//  DIInjection.h
//  EasyDIKit
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DIMethod;

typedef void(^DIInjectionParameters)(DIMethod * _Nonnull method);

@interface DIInjection : NSObject

- (void)injectProperty:(nonnull SEL)selector with:(nullable id)value;
- (void)injectMethod:(nonnull SEL)selector parameters:(nonnull DIInjectionParameters)parameters;

@end
