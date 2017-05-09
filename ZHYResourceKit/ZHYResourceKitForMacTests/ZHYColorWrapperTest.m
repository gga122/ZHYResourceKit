//
//  ZHYColorWrapperTest.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZHYColorWrapper+Plist.h"

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

    ZHYColorWrapper *colorWrapper = [[ZHYColorWrapper alloc] initWithPlist:testColorPlist];
    XCTAssertNotNil(colorWrapper);
}

@end
