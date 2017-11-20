//
//  DIInjectionTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DIInjection+Private.h"
#import "DIMethod+Private.h"

@interface InjectionTestObject : NSObject

@property (strong, nonatomic) NSString *prop1;
@property (strong, nonatomic) NSString *prop2;

@end

@implementation InjectionTestObject

@end

@interface DIMethod (UnitTests)

@property (strong, nonatomic) NSMutableArray *parameters;

@end

@interface DIInjection (UnitTests)

@property (strong, nonatomic) id target;
@property (strong, nonatomic) NSMutableDictionary *propertyInjections;
@property (strong, nonatomic) NSMutableArray *methodInjections;

@end

@interface DIInjectionTests : XCTestCase

@end

@implementation DIInjectionTests

- (void)testInitInjection {
    NSObject *target = [NSObject new];
    DIInjection *injection = [[DIInjection alloc] initWithTarget:target];
    XCTAssertNotNil(injection);
    XCTAssertEqualObjects(injection.target, target);
}

- (void)testInitInjectionWithoutTarget {
    void(^init)(id) = ^(id target) {
        __unused DIInjection *injection = [[DIInjection alloc] initWithTarget:target];
    };
    
    XCTAssertThrowsSpecificNamed(init(nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil target.");
}

- (void)testInjectProperty {
    DIInjection *injection = [[DIInjection alloc] initWithTarget:[InjectionTestObject new]];
    [injection injectProperty:@selector(prop1) with:@"str1"];
    XCTAssertEqualObjects(injection.propertyInjections[NSStringFromSelector(@selector(prop1))], @"str1");
}

- (void)testInjectPropertyWithNilValue {
    DIInjection *injection = [[DIInjection alloc] initWithTarget:[InjectionTestObject new]];
    [injection injectProperty:@selector(prop1) with:nil];
    XCTAssertEqualObjects(injection.propertyInjections[NSStringFromSelector(@selector(prop1))], NSNull.null);
}

- (void)testInjectMethod {
    NSString *param1 = @"str1";
    
    DIInjection *injection = [[DIInjection alloc] initWithTarget:[InjectionTestObject new]];
    [injection injectMethod:@selector(setProp1:) parameters:^(DIMethod *method) {
        [method injectParameter:param1];
    }];
    
    DIMethod *method = injection.methodInjections.firstObject;
    
    XCTAssertNotNil(injection.methodInjections.firstObject);
    XCTAssertEqualObjects(method.parameters.firstObject, param1);
}

- (void)testInjectMethodWithoutParameters {
    void(^injectMethod)(DIInjectionParameters) = ^(DIInjectionParameters parameters) {
        DIInjection *injection = [[DIInjection alloc] initWithTarget:[InjectionTestObject new]];
        [injection injectMethod:@selector(setProp1:) parameters:parameters];
    };
    
    XCTAssertThrowsSpecificNamed(injectMethod(nil), NSException, DIInvalidArgumentException, @"The method must throw an exception if you pass a nil parameters.");
}

- (void)testPerform {
    NSString *prop1 = @"str1";
    NSString *prop2 = @"str2";
    
    InjectionTestObject *obj = [InjectionTestObject new];
    DIInjection *injection = [[DIInjection alloc] initWithTarget:obj];
    [injection injectProperty:@selector(prop1) with:prop1];
    [injection injectMethod:@selector(setProp2:) parameters:^(DIMethod *method) {
        [method injectParameter:prop2];
    }];
    
    [injection perform];
    
    XCTAssertEqualObjects(obj.prop1, prop1);
    XCTAssertEqualObjects(obj.prop2, prop2);
}

@end
