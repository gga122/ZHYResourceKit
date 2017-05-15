//
//  ZHYFontWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYFontWrapper.h"

@implementation ZHYFontWrapper

- (ZHYFont *)font {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYFontTransformer];
}

@end

@implementation ZHYFontInfo

- (instancetype)initWithDescriptor:(NSDictionary *)descriptor forName:(NSString *)name {
    BOOL isGuard = (!descriptor || !name);
    if (isGuard) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _descriptor = [descriptor copy];
    }
    
    return self;
}

- (id)content {
    return self.descriptor;
}

- (void)setContent:(id)content {
    if (![content isKindOfClass:[NSDictionary class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"Invalid content type. <content: %@>", content];
    } else {
        self.descriptor = content;
    }
}



@end
