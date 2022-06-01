//
//  HDCrashReceiver.h
//  HDTool
//
//  Created by 黄山锋 on 2022/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDCrashReceiver : NSObject

/// 打印Crash日志
/// @param obj 对象（实例对象/类对象）
/// @param aSelector 方法
/// @param isMetaClass 类/元类
/// @param title 标题
/// @param info 日志信息
+ (void)printCrashLogWithObj:(id)obj aSelector:(SEL)aSelector isMetaClass:(BOOL)isMetaClass title:(NSString *)title info:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
