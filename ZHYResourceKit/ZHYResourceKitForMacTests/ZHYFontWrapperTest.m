//
//  ZHYFontWrapperTest.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZHYFontWrapperTest : XCTestCase

@end

@implementation ZHYFontWrapperTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadSingleFontPlist {
    NSFontManager *fontManager = [[NSFontManager alloc] init];
    NSArray *fontFamily = fontManager.availableFontFamilies;
    NSArray *font = fontManager.availableFonts;
    NSLog(@"sasas");
}


@end
