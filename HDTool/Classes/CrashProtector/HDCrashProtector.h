//
//  HDCrashProtector.h
//  HDTool
//
//  Created by 黄山锋 on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import "NSObject+HDSelectorCrash.h"
#import "NSObject+HDKvcCrash.h"
#import "NSObject+HDKvoCrash.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, HDCrashProtectorOption) {
    HDCrashProtectorOptionAll            = 1 << 0, // 全部
    HDCrashProtectorOptionSelector       = 1 << 1, // 方法找不到
    HDCrashProtectorOptionKVC            = 1 << 2, // KVC
    HDCrashProtectorOptionKVO            = 1 << 3, // KVO
    HDCrashProtectorOptionTimer          = 1 << 4, // 定时器
    HDCrashProtectorOptionBounceSafe     = 1 << 5, // 边界安全
};

@interface HDCrashProtector : NSObject

//#pragma mark - func
///// 开启崩溃防护
///// @param option 崩溃类型（可多选）
+ (void)openWithOption:(HDCrashProtectorOption)option;


@end

NS_ASSUME_NONNULL_END
