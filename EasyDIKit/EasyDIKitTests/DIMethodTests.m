//
//  DIMethodTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DIMethod+Private.h"

@interface DIMethod (UnitTests)

@property (strong, nonatomic) NSMutableArray *parameters;

@end

@interface DIMethodTests : XCTestCase

@end

@implementation DIMethodTests

- (void)testInit {
    DIMethod *method = [[DIMethod alloc] initWithTarget:NSObject.class selector:@selector(new)];
    XCTAssertNotNil(method);
    XCTAssertEqual(method.target, NSObject.class);
    XCTAssertEqual(method.selector, @selector(new));
}

- (void)testInitWithoutTarget {
    void(^init)(id, SEL) = ^(id target, SEL selector) {
        __unused DIMethod *method = [[DIMethod alloc] initWithTarget:target selector:selector];
    };
    
    XCTAssertThrowsSpecificNamed(init(nil, @selector(new)), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil target.");
}

- (void)testInitWithoutSelector {
    void(^init)(id, SEL) = ^(id target, SEL selector) {
        __unused DIMethod *method = [[DIMethod alloc] initWithTarget:target selector:selector];
    };
    
    XCTAssertThrowsSpecificNamed(init(NSObject.class, nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil selector.");
}

- (void)testInjectParameter {
    DIMethod *method = [[DIMethod alloc] initWithTarget:NSObject.class selector:@selector(new)];
    [method injectParameter:@"str"];
    XCTAssertEqualObjects(@"str", method.parameters.firstObject);
}

- (void)testInjectNilParameter {
    DIMethod *method = [[DIMethod alloc] initWithTarget:NSObject.class selector:@selector(new)];
    [method injectParameter:nil];
    XCTAssertEqualObjects(NSNull.null, method.parameters.firstObject);
}

- (void)testPerform {
    DIMethod *method  = [[DIMethod alloc] initWithTarget:NSObject.class selector:@selector(new)];
    XCTAssertNotNil([method perform]);
}

@end
