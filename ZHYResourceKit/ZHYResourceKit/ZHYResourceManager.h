//
//  ZHYResourceManager.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
typedef UIImage ZHYImage;
typedef UIFont ZHYFont;
typedef UIColor ZHYColor;
#else
#import <Cocoa/Cocoa.h>
typedef NSImage ZHYImage;
typedef NSFont ZHYFont;
typedef NSColor ZHYColor;
#endif


NS_ASSUME_NONNULL_BEGIN

/**
 Resource manager handle all resources with bundles.
 */
@interface ZHYResourceManager : NSObject

+ (instancetype)defaultManager;

- (BOOL)loadConfigurations:(NSString *)filePath;
- (void)unloadConfigurations;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSDictionary *> *configurations;

- (BOOL)loadbundle:(NSString *)bundleKey;
@property (nonatomic, copy, readonly) NSString *currentBundle;

- (ZHYColor *)colorForName:(NSString *)name;
- (ZHYImage *)imageForName:(NSString *)name;
- (ZHYFont *)fontForName:(NSString *)name;

- (id)resourceForName:(NSString *)name ofClassification:(NSString *)classification;

@end

NS_ASSUME_NONNULL_END
