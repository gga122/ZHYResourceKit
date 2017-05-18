//
//  ZHYResourceManager.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYResourceManager+Private.h"
#import "ZHYResourceKitDefines.h"

/**** Configuration notifications ****/
NSString * const kZHYResourceConfigurationsWillUnloadNotification = @"kZHYResourceConfigurationsWillUnloadNotification";
NSString * const kZHYResourceConfigurationsDidUnloadNotification = @"kZHYResourceConfigurationsDidUnloadNotification";
NSString * const kZHYResourceKeyConfigurations = @"configurations";

/**** Bundle notifications ****/
NSString * const kZHYResourceBundleWillLoadNotification = @"kZHYResourceBundleWillLoadNotification";
NSString * const kZHYResourceBundleDidLoadNotification = @"kZHYResourceBundleDidLoadNotification";

NSString * const kZHYResourceBundleWillUnloadNotification = @"kZHYResourceBundleWillUnloadNotification";
NSString * const kZHYResourceBundleDidUnloadNotification = @"kZHYResourceBundleDidUnloadNotification";
NSString * const kZHYResourceKeyBundle = @"bundle";

static ZHYResourceManager *s_globalManager;

@interface ZHYResourceManager ()

@property (nonatomic, copy, readwrite) NSDictionary<NSString *, NSDictionary *> *configurations;

@property (nonatomic, strong, readwrite) ZHYResourceCenter *currentCenter;

@end

@implementation ZHYResourceManager

#pragma mark - Overridden

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_globalManager = [[ZHYResourceManager alloc] init];
    });
}

- (instancetype)init {
    if (s_globalManager) {
        return s_globalManager;
    }
    
    self = [super init];
    if (self) {
        ZHYLogDebug(@"ZHYResource manager did init");
    }
    
    return self;
}

#pragma mark - Public Methods

+ (instancetype)defaultManager {
    return s_globalManager;
}

#pragma mark - Public Methods (Resource)

- (ZHYColor *)colorForName:(NSString *)name {
    return [self resourceForName:name ofClassification:kZHYResourceKeyTypeColor];
}

- (ZHYImage *)imageForName:(NSString *)name {
    return [self resourceForName:name ofClassification:kZHYResourceKeyTypeImage];
}

- (ZHYFont *)fontForName:(NSString *)name {
    return [self resourceForName:name ofClassification:kZHYResourceKeyTypeFont];
}

- (id)resourceForName:(NSString *)name ofClassification:(NSString *)classification {
    return [self.currentCenter resourceForName:name ofClassification:classification];
}

#pragma mark - Public Methods (Configuration)

- (BOOL)loadConfigurations:(NSString *)filePath {
    if (!filePath) {
        ZHYLogError(@"File path is nil");
        return NO;
    }
    
    BOOL isDirectory = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!existed || isDirectory) {
        ZHYLogError(@"Invalid file path. <filePath: %@>", filePath);
        return NO;
    }
    
    [self unloadConfigurations];
    
    self.configurations = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (!self.configurations) {
        ZHYLogError(@"Invalid configuration format.");
        return NO;
    }

    [self loadbundleWithKey:kZHYResourceKeyBundle];
    
    return YES;
}

- (void)unloadConfigurations {
    if (self.configurations) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kZHYResourceConfigurationsWillUnloadNotification object:self userInfo:nil];
        
        self.configurations = nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kZHYResourceConfigurationsDidUnloadNotification object:self userInfo:nil];
    } else {
        NSAssert(self.configurations, @"Configurations is nil");
        
    }
}

#pragma mark - Public Methods (Bundle)

- (BOOL)loadbundleWithKey:(NSString *)bundleKey {
    if (!bundleKey) {
        ZHYLogError(@"Bundle key is nil");
        return NO;
    }
    
    NSDictionary<NSString *, id> *configuration = [self.configurations objectForKey:bundleKey];
    if (!configuration) {
        ZHYLogError(@"Failed to find configuration for '%@'.", bundleKey);
        return NO;
    }
    
    
    
    
    return YES;
}

- (NSString *)currentBundle {
    return self.currentCenter.bundle.bundleIdentifier;
}

#pragma mark - Private Methods (Bundle)

- (void)loadBundle:(NSBundle *)bundle {
    [self unloadBundle]; // unload current bundle before load new one
    
    ZHYResourceCenter *center = [[ZHYResourceCenter alloc] initWithBundle:bundle];
    NSDictionary *userInfo = nil;
    if (center.bundle) {
        userInfo = @{kZHYResourceKeyBundle: center.bundle};
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZHYResourceBundleWillLoadNotification object:self userInfo:userInfo];
    
    self.currentCenter = center;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZHYResourceBundleDidLoadNotification object:self userInfo:userInfo];
}

- (void)unloadBundle {
    ZHYResourceCenter *center = self.currentCenter;
    
    if (center) {
        NSDictionary *userInfo = nil;
        if (center.bundle) {
            userInfo = @{kZHYResourceKeyBundle: center.bundle};
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kZHYResourceBundleWillUnloadNotification object:self userInfo:userInfo];
        
        self.currentCenter = nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kZHYResourceBundleDidUnloadNotification object:self userInfo:userInfo];
    }
}

#pragma mark - Private Property

- (NSArray *)allFontWrappers {
    ZHYResourceNode *fontNode = [self.currentCenter resourceNodeForClassification:kZHYResourceKeyTypeFont];
    return fontNode.allResourceWrappers;
}

- (NSArray *)allColorWrappers {
    ZHYResourceNode *colorNode = [self.currentCenter resourceNodeForClassification:kZHYResourceKeyTypeColor];
    return colorNode.allResourceWrappers;
}

- (NSArray *)allImageWrappers {
    ZHYResourceNode *imageNode = [self.currentCenter resourceNodeForClassification:kZHYResourceKeyTypeImage];
    return imageNode.allResourceWrappers;
}

@end
