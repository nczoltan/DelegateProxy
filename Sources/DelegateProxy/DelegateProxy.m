//
//  DelegateProxy.m
//  MemberAppPOC
//
//  Created by Zoltan Szabo on 2020. 07. 18..
//  Copyright © 2020. ddits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelegateProxy.h"

@interface DelegateProxy ()
@property (nonnull, nonatomic, strong) NSHashTable<NSObject *> *delegates;
@end

@implementation DelegateProxy

- (instancetype)initWithDelegates:(NSArray<id> *)delegates {
    self = [super init];
    if (self != nil) {
        self.delegates = [NSHashTable weakObjectsHashTable];
        for (id delegate in delegates) {
            if (![delegate isKindOfClass:[NSObject class]]) {
                continue;
            }
            if ([delegate isKindOfClass:[NSNull class]]) {
                continue;
            }
            [self.delegates addObject:delegate];
        }
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    for (NSObject *delegate in self.delegates) {
        if ([delegate respondsToSelector:aSelector]) {
            return [delegate methodSignatureForSelector:aSelector];
        }
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (NSObject *delegate in self.delegates) {
        if ([delegate respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:delegate];
        }
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    for (NSObject *delegate in self.delegates) {
        if ([delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}
@end
