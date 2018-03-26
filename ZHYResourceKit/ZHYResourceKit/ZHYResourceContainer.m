//
//  ZHYResourceContainer.m
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 28/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceContainer.h"
#import "ZHYResourceWrapper.h"
#import "ZHYLogger.h"

/* Resource Wrapper Valid Check Macro */

#define WRAPPER_NIL_CONDITION(wrapper)\
if (wrapper == nil) {\
    return;\
}\

#define WRAPPER_TYPE_CONDITION(wrapper)\
if (![self canAcceptResourceWrapper:wrapper]) {\
    ZHYLogWarning(@"'%@' can not add '%@' because of resource type not matched.", self, resourceWrapper);\
    return;\
}\

@interface ZHYResourceContainer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceWrapper *> *wrappers;

@end

@implementation ZHYResourceContainer

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceType = [resourceType copy];
        _wrappers = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark - Public Property

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    WRAPPER_NIL_CONDITION(resourceWrapper);
    WRAPPER_TYPE_CONDITION(resourceWrapper);
    
    ZHYResourceWrapper *conflictedWrapper = [self conflictedResourceWrapper:resourceWrapper dequeue:YES];
    id<ZHYResourceContainerDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(resourceContainer:willAddWrapper:conflictedWrapper:)]) {
        [delegate resourceContainer:self willAddWrapper:resourceWrapper conflictedWrapper:conflictedWrapper];
    }
    
    [self.wrappers setObject:resourceWrapper forKey:resourceWrapper.resourceName];
    
    if ([delegate respondsToSelector:@selector(resourceContainer:didAddWrapper:conflictedWrapper:)]) {
        [delegate resourceContainer:self didAddWrapper:resourceWrapper conflictedWrapper:conflictedWrapper];
    }
}

- (void)removeResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    WRAPPER_NIL_CONDITION(resourceWrapper);
    WRAPPER_TYPE_CONDITION(resourceWrapper);
    
    ZHYResourceWrapper *conflictedWrapper = [self conflictedResourceWrapper:resourceWrapper dequeue:NO];
    if (conflictedWrapper == nil) {
        return;
    }
    
    if (![resourceWrapper isEqual:conflictedWrapper]) {
        return;
    }
    
    id<ZHYResourceContainerDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(resourceContainer:willRemoveWrapper:)]) {
        [delegate resourceContainer:self willRemoveWrapper:conflictedWrapper];
    }
    
    [self.wrappers removeObjectForKey:conflictedWrapper.resourceName];
    
    if ([delegate respondsToSelector:@selector(resourceContainer:didRemoveWrapper:)]) {
        [delegate resourceContainer:self didRemoveWrapper:conflictedWrapper];
    }
}

#pragma mark - Private Methods

- (BOOL)canAcceptResourceWrapper:(nonnull ZHYResourceWrapper *)wrapper {
    NSString *resourceType = wrapper.resourceType;
    return [self.resourceType isEqualToString:resourceType];
}

- (nullable ZHYResourceWrapper *)conflictedResourceWrapper:(nonnull ZHYResourceWrapper *)wrapper dequeue:(BOOL)dequeue {
    NSString *key = wrapper.resourceName;
    ZHYResourceWrapper *conflictedWrapper = [self.wrappers objectForKey:key];
    if (dequeue && conflictedWrapper != nil) {
        [self.wrappers removeObjectForKey:key];
    }
    
    return conflictedWrapper;
}

#pragma mark - Public Property

- (NSArray<ZHYResourceWrapper *> *)allResourceWrappers {
    return self.wrappers.allValues;
}

@end
