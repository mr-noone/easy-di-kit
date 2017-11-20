//
//  NSInvocation+AdditionalTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 17.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSInvocation+Additional.h"

@interface InvokationTestObject : NSObject

@property NSString *param1;
@property NSString *param2;
@property NSString *param3;

- (instancetype)initWithParam1:(NSString *)param1
                        param2:(NSString *)param2
                        param3:(NSString *)param3;

@end

@implementation InvokationTestObject

- (instancetype)initWithParam1:(NSString *)param1 param2:(NSString *)param2 param3:(NSString *)param3 {
    self = [self init];
    self.param1 = param1;
    self.param2 = param2;
    self.param3 = param3;
    return self;
}

@end

@interface NSInvocation_AdditionalTests : XCTestCase

@end

@implementation NSInvocation_AdditionalTests

- (void)testInvokeWithClassMethod {
    XCTAssertNotNil([NSInvocation invokeWithTarget:NSObject.class selector:@selector(new) parameters:nil]);
}

- (void)testInvokeWithInstanceMethod {
    XCTAssertNotNil([NSInvocation invokeWithTarget:[NSObject alloc] selector:@selector(init) parameters:nil]);
}

- (void)testInvokeWithNilTarget {
    void(^invoke)(void) = ^{
        id target = nil;
        [NSInvocation invokeWithTarget:target selector:@selector(new) parameters:nil];
    };
    
    XCTAssertThrowsSpecificNamed(invoke(), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil target.");
}

- (void)testInvokeWithNilSelector {
    void(^invoke)(void) = ^{
        SEL selector = nil;
        [NSInvocation invokeWithTarget:NSObject.class selector:selector parameters:nil];
    };
    
    XCTAssertThrowsSpecificNamed(invoke(), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil selector.");
}

- (void)testInvokeWithUnsuportSelector {
    void(^invoke)(void) = ^{
        [NSInvocation invokeWithTarget:[NSObject alloc] selector:@selector(initWithFrame:) parameters:nil];
    };
    
    XCTAssertThrowsSpecificNamed(invoke(), NSException, DIUnrecognizedSelectorException, @"The method must throw an exception if target class does not conform the selector.");
}

- (void)testInvokeWithParameters {
    NSString *param1 = @"str1";
    NSString *param2 = @"str2";
    NSString *param3 = @"str3";
    
    InvokationTestObject *obj = [NSInvocation invokeWithTarget:[InvokationTestObject alloc]
                                                      selector:@selector(initWithParam1:param2:param3:)
                                                    parameters:@[param1, param2, param3]];
    
    XCTAssertNotNil(obj);
    XCTAssertEqualObjects(obj.param1, param1);
    XCTAssertEqualObjects(obj.param2, param2);
    XCTAssertEqualObjects(obj.param3, param3);
}

- (void)testInvokeWithNullParameters {
    InvokationTestObject *obj = [NSInvocation invokeWithTarget:[InvokationTestObject alloc]
                                                      selector:@selector(initWithParam1:param2:param3:)
                                                    parameters:@[NSNull.null, NSNull.null, NSNull.null]];
    
    XCTAssertNotNil(obj);
    XCTAssertNil(obj.param1);
    XCTAssertNil(obj.param2);
    XCTAssertNil(obj.param3);
}

@end
