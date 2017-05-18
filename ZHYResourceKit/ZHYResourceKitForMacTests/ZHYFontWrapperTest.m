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
    
    NSFont *font = [NSFont systemFontOfSize:12.0];
    NSFontDescriptor *fontDescriptor = font.fontDescriptor;
    
    NSDictionary *attributes = fontDescriptor.fontAttributes;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLoadSingleFontPlist {
    NSFontManager *fontManager = [[NSFontManager alloc] init];
    NSArray *fontFamily = fontManager.availableFontFamilies;
    NSArray *font = fontManager.availableFonts;
}


@end
