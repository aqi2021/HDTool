//
//  HDCrashProtector.m
//  HDTool
//
//  Created by 黄山锋 on 2022/5/20.
//

#import "HDCrashProtector.h"

@implementation HDCrashProtector


#pragma mark - func
/// 开启崩溃防护
/// @param option 崩溃类型（可多选）
+ (void)openWithOption:(HDCrashProtectorOption)option {
    if (option & HDCrashProtectorOptionAll) {
//        [NSObject hd_openSelectorCrashProtector];
//        [NSObject hd_openKvcCrashProtector];
        [NSObject hd_openKvoCrashProtector];
    }else{
        if (option & HDCrashProtectorOptionSelector) {
            [NSObject hd_openSelectorCrashProtector];
        }
        if (option & HDCrashProtectorOptionKVC) {
            [NSObject hd_openKvcCrashProtector];
        }
        if (option & HDCrashProtectorOptionKVO) {
            [NSObject hd_openKvoCrashProtector];
        }
        if (option & HDCrashProtectorOptionTimer) {
            
        }
        if (option & HDCrashProtectorOptionBounceSafe) {
            
        }
    }
}

@end
