//
//  ZHYVersionComponents.m
//  ZHYResourceKit
//
//  Created by Henry on 2018/10/21.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYVersionComponents.h"

static NSCharacterSet *s_globalVersionCharacterSet = nil;

static NSString * const kZHYVersionComponentsCodingKeyVersionValue = @"versionValue";

@interface ZHYVersionComponents ()

@property (nonatomic, strong) NSArray<NSString *> *values;

@end

@implementation ZHYVersionComponents

#pragma mark - DESIGNATED INITIALIZER

- (nullable instancetype)initWithVersionValue:(NSString *)versionValue {
    versionValue = [versionValue stringByTrimmingCharactersInSet:s_globalVersionCharacterSet];
    
    self = [super init];
    if (self) {
        _values = [versionValue componentsSeparatedByString:@"."];
    }
    
    return self;
}

#pragma mark - Overridden

+ (void)initialize {
    if (self == [ZHYVersionComponents self]) {
        s_globalVersionCharacterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"1234567890."];
    }
}

- (instancetype)init {
    return [self initWithVersionValue:@"0.0.0.0"];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:[super description]];
    
    [description appendFormat:@"<major: %@>", self.majorValue];
    [description appendFormat:@"<minor: %@>", self.minorValue];
    [description appendFormat:@"<patch: %@>", self.patchValue];
    [description appendString:@"<build: %@>", self.buildValue];
    
    return description;
}

#pragma mark - Public Methods

- (NSComparisonResult)compare:(ZHYVersionComponents *)components {
    if (self.major > components.major) {
        return NSOrderedDescending;
    } else if (self.major < components.major) {
        return NSOrderedAscending;
    }
    
    if (self.minor > components.minor) {
        return NSOrderedDescending;
    } else if (self.minor < components.minor) {
        return NSOrderedAscending;
    }
    
    if (self.patch > components.patch) {
        return NSOrderedDescending;
    } else if (self.patch < components.patch) {
        return NSOrderedAscending;
    }
    
    if (self.build > components.build) {
        return NSOrderedDescending;
    } else if (self.build < components.build) {
        return NSOrderedAscending;
    }
    
    return NSOrderedSame;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYVersionComponents *vc = [[ZHYVersionComponents allocWithZone:zone] initWithVersionValue:self.versionValue];
    return vc;
}

#pragma mark - NSSecureCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.versionValue forKey:kZHYVersionComponentsCodingKeyVersionValue];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *versionValue = [aDecoder decodeObjectForKey:kZHYVersionComponentsCodingKeyVersionValue];
    return [self initWithVersionValue:versionValue];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - Public Property

- (NSString *)versionValue {
    return [NSString stringWithFormat:@"%@.%@.%@.%@", self.majorValue, self.minorValue, self.patchValue, self.buildValue];
}

- (NSString *)majorValue {
    if (self.values.count > 0) {
        return [self.values objectAtIndex:0];
    }
    return @"0";
}

- (NSString *)minorValue {
    if (self.values.count > 1) {
        return [self.values objectAtIndex:1];
    }
    return @"0";
}

- (NSString *)patchValue {
    if (self.values.count > 2) {
        return [self.values objectAtIndex:2];
    }
    return @"0";
}

- (NSString *)buildValue {
    if (self.values.count > 3) {
        return [self.values objectAtIndex:3];
    }
    return @"0";
}

- (NSInteger)major {
    return [self.majorValue integerValue];
}

- (NSInteger)minor {
    return [self.minorValue integerValue];
}

- (NSInteger)patch {
    return [self.patchValue integerValue];
}

- (NSInteger)build {
    return [self.buildValue integerValue];
}

@end
