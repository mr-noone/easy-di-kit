//
//  DIInitializerTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 16.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DIInitializer+Private.h"
#import "DIMethod+Private.h"

@interface InitializerTestObject : NSObject

@property NSString *param1;
@property NSString *param2;
@property NSString *param3;

- (instancetype)initWithParam1:(NSString *)param1
                        param2:(NSString *)param2
                        param3:(NSString *)param3;

@end

@implementation InitializerTestObject

- (instancetype)initWithParam1:(NSString *)param1 param2:(NSString *)param2 param3:(NSString *)param3 {
    self = [self init];
    self.param1 = param1;
    self.param2 = param2;
    self.param3 = param3;
    return self;
}

@end

@interface DIMethod (UnitTests)

@property (strong, nonatomic) NSMutableArray *parameters;

@end

@interface DIInitializer (UnitTests)

@property (assign, nonatomic) Class aClass;
@property (strong, nonatomic) DIMethod *method;
@property (strong, nonatomic) NSMutableArray *parameters;

@end

@interface DIInitializerTests : XCTestCase

@end

@implementation DIInitializerTests

- (void)testInitWithClass {
    DIInitializer *initializer = [[DIInitializer alloc] initWithClass:NSObject.class];
    XCTAssertNotNil(initializer);
    XCTAssertEqual(initializer.aClass, NSObject.class);
}

- (void)testInitWithClassWithouClass {
    void(^init)(Class) = ^(Class aClass) {
        __unused DIInitializer *initializer = [[DIInitializer alloc] initWithClass:aClass];
    };
    
    XCTAssertThrowsSpecificNamed(init(nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil class.");
}

- (void)testSetSelector {
    SEL selector = @selector(init);
    
    DIInitializer *initializer = [[DIInitializer alloc] initWithClass:NSObject.class];
    initializer.selector = selector;
    
    XCTAssertEqual(initializer.selector, selector);
    XCTAssertEqual(initializer.method.selector, selector);
}

- (void)testSetNilSelector {
    void(^setSelector)(SEL) = ^(SEL selector) {
        DIInitializer *initializer = [[DIInitializer alloc] initWithClass:NSObject.class];
        initializer.selector = selector;
    };
    
    XCTAssertThrowsSpecificNamed(setSelector(nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil selector.");
}

- (void)testInjectParameter {
    DIInitializer *initializer = [[DIInitializer alloc] initWithClass:NSObject.class];
    [initializer injectParameter:@"str"];
    XCTAssertEqualObjects(@"str", initializer.method.parameters.firstObject);
}

- (void)testInjectNilParameter {
    DIInitializer *initializer = [[DIInitializer alloc] initWithClass:NSObject.class];
    [initializer injectParameter:nil];
    XCTAssertEqualObjects(NSNull.null, initializer.method.parameters.firstObject);
}

- (void)testPerform {
    DIInitializer *initializer = [[DIInitializer alloc] initWithClass:NSObject.class];
    XCTAssertNotNil([initializer perform]);
}

- (void)testPerformWithParameters {
    NSString *param1 = @"str1";
    NSString *param2 = @"str2";
    NSString *param3 = nil;
    
    DIInitializer *initializer = [[DIInitializer alloc] initWithClass:InitializerTestObject.class];
    [initializer setSelector:@selector(initWithParam1:param2:param3:)];
    [initializer injectParameter:param1];
    [initializer injectParameter:param2];
    [initializer injectParameter:param3];
    InitializerTestObject *obj = [initializer perform];
    
    XCTAssertNotNil(obj);
    XCTAssertEqualObjects(obj.param1, param1);
    XCTAssertEqualObjects(obj.param2, param2);
    XCTAssertNil(obj.param3);
}

@end
