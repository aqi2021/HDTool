//
//  NSObject+HDSelectorCrash.m
//  HDTool
//
//  Created by 黄山锋 on 2022/5/20.
//

#import "NSObject+HDSelectorCrash.h"
#import "HDCrashReceiver.h"
#import <objc/runtime.h>
#import <HDCategory/HDCategory.h>

@implementation NSObject (HDSelectorCrash)

+ (void)hd_openSelectorCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 交换forwardingTargetForSelector:方法(类方法和对象方法)
        [NSObject hd_swizzleClassMethodWithClass:[NSObject class] originalSel:@selector(forwardingTargetForSelector:) swizzledMethod:@selector(hd_forwardingTargetForSelector:)];
        [NSObject hd_swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(forwardingTargetForSelector:) swizzledMethod:@selector(hd_forwardingTargetForSelector:)];        
    });
}

- (id)hd_forwardingTargetForSelector:(SEL)aSelector {
    BOOL should = _shouldForwardingTargetForSelector(aSelector);
    if (should) {
        [HDCrashReceiver printCrashLogWithObj:self aSelector:aSelector isMetaClass:NO title:@"SEL" info:@"unrecognized selector"];
        return _crashReceiverForSelector(aSelector);
    }
    return [self hd_forwardingTargetForSelector:aSelector];
}

+ (id)hd_forwardingTargetForSelector:(SEL)aSelector {
    BOOL should = _shouldForwardingTargetForSelector(aSelector);
    if (should) {
        [HDCrashReceiver printCrashLogWithObj:self aSelector:aSelector isMetaClass:YES title:@"SEL" info:@"unrecognized selector"];
        return _crashReceiverForSelector(aSelector);
    }
    return [self hd_forwardingTargetForSelector:aSelector];
}

/// 是否应该转发
BOOL _shouldForwardingTargetForSelector(SEL aSelector) {
    BOOL override_forwarding = NO;
    if (!override_forwarding) {
        BOOL override_methodSignature = NO;
        if (!override_methodSignature) {
            return YES;
        }
    }
    return NO;
}

/// 转发对象
id _crashReceiverForSelector(SEL aSelector) {
    NSString *className = @"HDCrashReceiver";
    Class cls = NSClassFromString(className);
    // 如果类不存在 动态创建一个类
    if (!cls) {
        Class superClsss = [NSObject class];
        cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
        objc_registerClassPair(cls);// 注册类
    }
    // 如果类没有对应的方法，则动态添加一个
    if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
        class_addMethod(cls, aSelector, (IMP)_crashProtect, "@@:@");
    }
    return [[cls alloc] init];
}

/// crash防护方法
static int _crashProtect(id slf, SEL selector) {
    return 0;
}


@end
