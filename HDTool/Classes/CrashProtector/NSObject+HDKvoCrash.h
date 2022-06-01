//
//  NSObject+HDKvoCrash.h
//  HDTool
//
//  Created by 黄山锋 on 2022/5/24.
//

#import <Foundation/Foundation.h>
#import "HDKvoInfo.h"
#import "HDKvoDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - HDKvoCrash
@interface NSObject (HDKvoCrash)
@property (nonatomic, strong) HDKvoDelegate *hd_delegate;
+ (void)hd_openKvoCrashProtector;
@end

NS_ASSUME_NONNULL_END
