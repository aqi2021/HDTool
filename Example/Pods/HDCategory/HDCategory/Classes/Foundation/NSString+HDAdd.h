//
//  NSString+HDAdd.h
//  HDCategory
//
//  Created by 黄山锋 on 2022/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 字符串拼接
#define HDStrFormat(fmt, ...) [NSString stringWithFormat:fmt, __VA_ARGS__]

@interface NSString (HDAdd)

/// 是否为空
- (BOOL)hd_isEmpty;

/// 获取去掉空格的字符串
- (NSString *)hd_trimStr;


#pragma mark - json
// MARK: TODO
/// json 转数组
- (NSArray *)hd_jsonToArray;

// MARK: TODO
/// json 转字段
- (NSDictionary *)hd_jsonToDict;



@end

NS_ASSUME_NONNULL_END
