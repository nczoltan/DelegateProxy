//
//  DelegateProxy.h
//  MemberAppPOC
//
//  Created by Zoltan Szabo on 2020. 07. 18..
//  Copyright © 2020. ddits. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DelegateProxy : NSObject
- (nonnull instancetype)initWithDelegates:(NSArray<id> * __nonnull)delegates NS_REFINED_FOR_SWIFT;
@end
