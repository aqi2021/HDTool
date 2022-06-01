//
//  NSArray+HDAdd.m
//  HDCategory
//
//  Created by 黄山锋 on 2022/5/19.
//

#import "NSArray+HDAdd.h"

@implementation NSArray (HDAdd)

/// 是否为空
- (BOOL)hd_isEmpty {
    return (self == nil || [self isKindOfClass:[NSNull class]] || self.count == 0);
}

@end
