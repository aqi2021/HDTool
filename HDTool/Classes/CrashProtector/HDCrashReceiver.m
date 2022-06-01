//
//  HDCrashReceiver.m
//  HDTool
//
//  Created by 黄山锋 on 2022/5/20.
//

#import "HDCrashReceiver.h"

@implementation HDCrashReceiver

/// 打印Crash日志
/// @param obj 对象（实例对象/类对象）
/// @param aSelector 方法
/// @param isMetaClass 类/元类
/// @param title 标题
/// @param info 日志信息
+ (void)printCrashLogWithObj:(id)obj aSelector:(SEL)aSelector isMetaClass:(BOOL)isMetaClass title:(NSString *)title info:(NSString *)info {
    NSString *errClassName = NSStringFromClass([obj class]);
    NSString *errSel = NSStringFromSelector(aSelector);
    NSString *msg = [NSString stringWithFormat:@"【%@】%@[%@ %@]: %p \n %@",title, isMetaClass?@"+":@"-", errClassName, errSel, obj, info];
    NSLog(@"-----[HDCrashProtector]-----\n %@ \n",msg);
}

@end
