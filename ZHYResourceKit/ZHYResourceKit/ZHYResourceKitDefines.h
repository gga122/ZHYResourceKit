//
//  ZHYResourceKitDefines.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 8/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#ifndef ZHYResourceKitDefines_h
#define ZHYResourceKitDefines_h

#import <Foundation/Foundation.h>

#define ZHY_DESCRIPTOR_PLIST_LEVEL(x, y)           // Do nothing, just mark key level, 'x' is current level, 'y' is total level

static NSString * const kZHYResourceDefaultBundleKey = @"default";

static NSString * const kZHYResourceStructDescriptorFileName = @"ZHYResourceStruct.descriptor.plist";

/***** Resource Type Keys *****/
static NSString * const kZHYResourceKeyTypeColor = @"zhy.resourceKit.resource.color";
static NSString * const kZHYResourceKeyTypeFont = @"zhy.resoureKit.resource.font";
static NSString * const kZHYResourceKeyTypeImage = @"zhy.resourceKit.resource.image";

/***** Color Plist Keys *****/
static NSString * const kZHYColorKeyName = @"name" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 1);                         // required
static NSString * const kZHYColorKeyColorHex = @"color" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 1);                    // required
static NSString * const kZHYColorKeyDetail = @"detail" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 1);                     // optional

/***** Font Plist Keys *****/
static NSString * const kZHYFontKeyName = @"name" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 2);                          // required
static NSString * const kZHYFontKeyFont = @"font" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 2);                          // required
static NSString * const kZHYFontKeyFontFamily = @"family" ZHY_DESCRIPTOR_PLIST_LEVEL(2, 2);                      // optional
static NSString * const kZHYFontKeyFontName = @"name" ZHY_DESCRIPTOR_PLIST_LEVEL(2, 2);                          // optional
static NSString * const kZHYFontKeyFontSize = @"size" ZHY_DESCRIPTOR_PLIST_LEVEL(2, 2);                          // required
static NSString * const kZHYFontKeyFontTrait = @"trait" ZHY_DESCRIPTOR_PLIST_LEVEL(2, 2);                        // optional
static NSString * const kZHYFontKeyDetail = @"detail" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 2);                      // optional

/***** Image Plist Keys *****/
static NSString * const kZHYImageKeyName = @"name" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 1);                         // required
static NSString * const kZHYImageKeyPath = @"path" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 1);                         // required
static NSString * const kZHYImageKeyDetail = @"detail" ZHY_DESCRIPTOR_PLIST_LEVEL(1, 1);                     // optional

#endif /* ZHYResourceKitDefines_h */
