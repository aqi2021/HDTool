//
//  NSObject+HDAdd.h
//  HDCategory
//
//  Created by 黄山锋 on 2022/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HDAdd)

/// 获取类名
+ (NSString *)hd_className;
- (NSString *)hd_className;

/// 是否为空
- (BOOL)hd_isEmpty;

/// 判断某个类的某个方法是否被重写过
/// @param cls 类
/// @param aSelector 方法
+ (BOOL)hd_checkMethodIsOverrideWithCls:(Class)cls aSelector:(SEL)aSelector;

#pragma mark - 方法交换

/// 交换类方法
/// @param cls 类名
/// @param originalSel 原方法
/// @param swizzledMethod 交换方法
+ (void)hd_swizzleClassMethodWithClass:(Class)cls originalSel:(SEL)originalSel swizzledMethod:(SEL)swizzledMethod;

/// 交换对象方法
/// @param cls 类名
/// @param originalSel 原方法
/// @param swizzledMethod 交换方法
+ (void)hd_swizzleInstanceMethodWithClass:(Class)cls originalSel:(SEL)originalSel swizzledMethod:(SEL)swizzledMethod;


@end

NS_ASSUME_NONNULL_END
