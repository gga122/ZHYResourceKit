//
//  ZHYResourceKitForMacTests.m
//  ZHYResourceKitForMacTests
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZHYResourceCenter.h"
#import "ZHYLogger.h"

@interface ZHYResourceKitForMacTests : XCTestCase

@end

@implementation ZHYResourceKitForMacTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    ZHYResourceCenter *center = [[ZHYResourceCenter alloc] initWithBundle:[NSBundle mainBundle]];
    
    ZHYLogError(@"hello %@", center);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
