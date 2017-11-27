//
//  DIAssemblyTests.m
//  EasyDIKitTests
//
//  Created by Aleksey Zgurskiy on 20.11.2017.
//  Copyright © 2017 Aleksey Zgurskiy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DIAssembly.h"
#import "DIFactory+TestsHelers.h"

@interface TestAssembly : DIAssembly
@end

@implementation TestAssembly
@end

@interface TestAppAssembly : DIAssembly

@property (strong, nonatomic) TestAssembly *testAssembly;

@end

@implementation TestAppAssembly
@end

@interface DIAssemblyTests : XCTestCase

@end

@implementation DIAssemblyTests

- (void)tearDown {
    [DIFactory clearSingletons];
    [super tearDown];
}

- (void)testAssemblySingleton {
    TestAppAssembly *assembly1 = TestAppAssembly.assembly;
    TestAppAssembly *assembly2 = TestAppAssembly.assembly;
    XCTAssertEqualObjects(assembly1, assembly2, @"The assembly must be singleton");
}

- (void)testAutoInjectProperties {
    TestAppAssembly *appAssembly = TestAppAssembly.assembly;
    XCTAssertNotNil(appAssembly.testAssembly, @"If property has parent class 'DIAssembly' it should injected automatically.");
}

@end
