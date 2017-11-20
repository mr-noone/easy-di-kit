//
//  DIFactory+TestsHelers.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 21.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import "DIFactory+TestsHelers.h"

@interface DIFactory ()

@property (class, nonatomic, readonly) NSMutableDictionary *singletons;

@end

@implementation DIFactory (TestsHelers)

+ (void)clearSingletons {
    NSArray *keys = [DIFactory.singletons allKeys];
    for (NSString *key in keys) {
        [DIFactory.singletons removeObjectForKey:key];
    }
}

@end
