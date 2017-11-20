//
//  DIFactoryTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 16.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DIFactory.h"
#import "DIInitializer.h"
#import "DIInjection.h"

#import "DIFactory+TestsHelers.h"

@interface FactoryTestObject : NSObject

@property (strong, nonatomic) NSString *param1;
@property (strong, nonatomic) NSString *param2;

- (instancetype)initWithParam1:(NSString *)param1 param2:(NSString *)param2;

@end

@implementation FactoryTestObject

- (instancetype)initWithParam1:(NSString *)param1 param2:(NSString *)param2 {
    self = [super init];
    
    _param1 = param1;
    _param2 = param2;
    
    return self;
}

@end

@interface DIFactoryTests : XCTestCase

@end

@implementation DIFactoryTests

- (void)tearDown {
    [DIFactory clearSingletons];
    [super tearDown];
}

- (void)testInstanceOfClass {
    XCTAssertNotNil([DIFactory instanceOfClass:NSObject.class]);
}

- (void)testInstanceOfClassWithoutClass {
    void(^instanceOfClass)(Class) = ^(Class aClass) {
        __unused id instance = [DIFactory instanceOfClass:aClass];
    };
    
    XCTAssertThrowsSpecificNamed(instanceOfClass(nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil class.");
}

- (void)testInstanceOfClassWithInitializer {
    NSString *param1 = @"str1";
    NSString *param2 = @"str2";
    
    DIFactoryInitializer initializer = ^(DIInitializer *initializer) {
        initializer.selector = @selector(initWithParam1:param2:);
        [initializer injectParameter:param1];
        [initializer injectParameter:param2];
    };
    
    FactoryTestObject *obj = [DIFactory instanceOfClass:FactoryTestObject.class
                                            initializer:initializer
                                             injections:nil];
    
    XCTAssertNotNil(obj);
    XCTAssertEqualObjects(obj.param1, param1);
    XCTAssertEqualObjects(obj.param2, param2);
}

- (void)testInstanceOfClassWithInjection {
    NSString *param1 = @"str1";
    NSString *param2 = @"str2";
    
    DIFactoryInjections injections = ^(DIInjection *injections) {
        [injections injectProperty:@selector(param1) with:param1];
        [injections injectProperty:@selector(param2) with:param2];
    };
    
    FactoryTestObject *obj = [DIFactory instanceOfClass:FactoryTestObject.class
                                            initializer:nil
                                             injections:injections];
    
    XCTAssertNotNil(obj);
    XCTAssertEqualObjects(obj.param1, param1);
    XCTAssertEqualObjects(obj.param2, param2);
}

- (void)testSingletonOfClass {
    FactoryTestObject *obj1 = [DIFactory singletonOfClass:FactoryTestObject.class];
    FactoryTestObject *obj2 = [DIFactory singletonOfClass:FactoryTestObject.class];
    XCTAssertEqualObjects(obj1, obj2);
}

- (void)testSingletonOfClassWithoutClass {
    void(^instanceOfClass)(Class) = ^(Class aClass) {
        __unused id instance = [DIFactory singletonOfClass:aClass];
    };
    
    XCTAssertThrowsSpecificNamed(instanceOfClass(nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil class.");
}

@end
