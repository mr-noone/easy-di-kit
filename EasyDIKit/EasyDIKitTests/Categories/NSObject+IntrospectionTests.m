//
//  NSObject+IntrospectionTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 21.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+Introspection.h"

@interface IntrospectionTestObject : NSObject

@property (strong, nonatomic) NSString *prop1;
@property (assign, nonatomic) BOOL prop2;

@end

@implementation IntrospectionTestObject
@end

@interface NSObject_IntrospectionTests : XCTestCase

@end

@implementation NSObject_IntrospectionTests

- (void)testClassOfProperty {
    Class class = [IntrospectionTestObject classOfProperty:NSStringFromSelector(@selector(prop1))];
    XCTAssertEqualObjects(class, NSString.class, @"The method must return Class if property is kind of object type.");
}

- (void)testClassOfPropertyWithCTypeProperty {
    Class class = [IntrospectionTestObject classOfProperty:NSStringFromSelector(@selector(prop2))];
    XCTAssertNil(class, @"The method must return nil if property is kind of C type.");
}

@end
