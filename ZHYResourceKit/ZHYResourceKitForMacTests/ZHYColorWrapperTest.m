//
//  ZHYColorWrapperTest.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZHYColorWrapper.h"

@interface ZHYColorWrapperTest : XCTestCase


@end

@implementation ZHYColorWrapperTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLoadSingleColorPlist {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Color" ofType:@"plist"];
    XCTAssertNotNil(path);
    
    NSDictionary<NSString *, NSString *> *testColorPlist = [NSDictionary dictionaryWithContentsOfFile:path];
    XCTAssertNotNil(testColorPlist);

    ZHYColorInfo *colorInfo = [ZHYColorInfo decodeFromPlist:testColorPlist];
    XCTAssertNotNil(colorInfo);
    
    ZHYColorWrapper *colorWrapper = [[ZHYColorWrapper alloc] initWithResourceInfo:colorInfo];
    XCTAssertNotNil(colorWrapper);
}

@end
