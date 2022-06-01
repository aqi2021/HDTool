//
//  NSObject+HDAdd.m
//  HDCategory
//
//  Created by 黄山锋 on 2022/5/19.
//

#import "NSObject+HDAdd.h"
#import <objc/runtime.h>

@implementation NSObject (HDAdd)

/// 获取类名
+ (NSString *)hd_className {
    return NSStringFromClass(self);
}
- (NSString *)hd_className {
    return NSStringFromClass([self class]);
}

/// 是否为空
- (BOOL)hd_isEmpty {
    return (self == nil || [self isKindOfClass:[NSNull class]]);
}

/// 判断某个类的某个方法是否被重写过
/// @param cls 类
/// @param aSelector 方法
+ (BOOL)hd_checkMethodIsOverrideWithCls:(Class)cls aSelector:(SEL)aSelector {
    IMP curImp = class_getMethodImplementation(cls, aSelector);
    if (!curImp) {
        // 方法不存在
        return NO;
    }
    Class superCls = class_getSuperclass(cls);
    IMP superImp = nil;
    while (superCls != nil) {
        cls = superCls;
        superImp = class_getMethodImplementation(cls, aSelector);
        if (superImp) {
            break;
        }
    }
    return curImp != superImp;
}

#pragma mark - 方法交换

/// 交换类方法
/// @param cls 类名
/// @param originalSel 原方法
/// @param swizzledMethod 交换方法
+ (void)hd_swizzleClassMethodWithClass:(Class)cls originalSel:(SEL)originalSel swizzledMethod:(SEL)swizzledMethod {
    swizzlingMethod(cls, YES, originalSel, swizzledMethod);
}

/// 交换对象方法
/// @param cls 类名
/// @param originalSel 原方法
/// @param swizzledMethod 交换方法
+ (void)hd_swizzleInstanceMethodWithClass:(Class)cls originalSel:(SEL)originalSel swizzledMethod:(SEL)swizzledMethod {
    swizzlingMethod(cls, NO, originalSel, swizzledMethod);
}

/// 交换方法
/// @param class 类/元类
/// @param originalSel 原方法
/// @param swizzledSel 交换方法
void swizzlingMethod(Class class, BOOL isMetaClass, SEL originalSel, SEL swizzledSel) {
    Method originalMethod;
    Method swizzledMethod;
    if (isMetaClass) {
        originalMethod = class_getClassMethod(class, originalSel);
        swizzledMethod = class_getClassMethod(class, swizzledSel);
    }else{
        originalMethod = class_getInstanceMethod(class, originalSel);
        swizzledMethod = class_getInstanceMethod(class, swizzledSel);
    }
    if (!originalMethod || !swizzledMethod) {
        NSLog(@"【Class】：%@中，方法交换失败 \n【originalSel】：%@ \n【swizzledSel】：%@ \n", class, NSStringFromSelector(originalSel), NSStringFromSelector(swizzledSel));
        return;
    }
    if (isMetaClass) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }else{
        BOOL didAddMethod = class_addMethod(class,
                                             originalSel,
                                             method_getImplementation(swizzledMethod),
                                             method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSel,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

@end
