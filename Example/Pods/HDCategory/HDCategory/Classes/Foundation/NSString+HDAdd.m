//
//  NSString+HDAdd.m
//  HDCategory
//
//  Created by 黄山锋 on 2022/5/19.
//

#import "NSString+HDAdd.h"

@implementation NSString (HDAdd)

/// 是否为空
- (BOOL)hd_isEmpty {
    return (self == nil || [self length] < 1 || [self isEqualToString:@"null"] || [self isEqualToString:@"Null"] || [self isKindOfClass:[NSNull class]] ? YES : NO );
}

/// 获取去掉空格的字符串
- (NSString *)hd_trimStr {
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}

@end
