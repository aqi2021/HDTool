//
//  NSObject+HDKvoCrash.m
//  HDTool
//
//  Created by 黄山锋 on 2022/5/24.
//

#import "NSObject+HDKvoCrash.h"
#import <objc/runtime.h>
#import <HDCategory/HDCategory.h>
#import "HDCrashReceiver.h"

@implementation NSObject (HDKvoCrash)

+ (void)hd_openKvoCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject hd_swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(addObserver:forKeyPath:options:context:) swizzledMethod:@selector(hd_addObserver:forKeyPath:options:context:)];
        // 因为调用 removeObserver:forKeyPath:context: 方法后，会调用 removeObserver:forKeyPath: 方法，所以这个方法没必要交换，这样的话context就不会影响是否为同一个info
        //[NSObject hd_swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(removeObserver:forKeyPath:context:) swizzledMethod:@selector(hd_removeObserver:forKeyPath:context:)];
        [NSObject hd_swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(removeObserver:forKeyPath:) swizzledMethod:@selector(hd_removeObserver:forKeyPath:)];
    });
}

#pragma mark setter/getter
- (HDKvoDelegate *)hd_delegate {
    HDKvoDelegate *obj = objc_getAssociatedObject(self, @selector(hd_delegate));
    if (!obj) {
        obj = [[HDKvoDelegate alloc]init];
        obj.observed = self;
        objc_setAssociatedObject(self, @selector(hd_delegate), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}
- (void)setHd_delegate:(HDKvoDelegate *)hd_delegate {
    objc_setAssociatedObject(self, @selector(hd_delegate), hd_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark kvo方法
- (void)hd_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    NSLog(@"%s",__func__);
    BOOL success = [self.hd_delegate addKvoInfoToMapsWithObserver:observer forKeyPath:keyPath options:options context:context];
    if (success) {
        [self hd_addObserver:self.hd_delegate forKeyPath:keyPath options:options context:context];
    }
}
- (void)hd_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    NSLog(@"%s",__func__);
    BOOL success = [self.hd_delegate removeKvoInfoToMapsWithObserver:observer forKeyPath:keyPath options:0 context:context];
    if (success) {
        [self hd_removeObserver:self.hd_delegate forKeyPath:keyPath context:context];
    }
}
- (void)hd_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSLog(@"%s",__func__);
    BOOL success = [self.hd_delegate removeKvoInfoToMapsWithObserver:observer forKeyPath:keyPath options:0 context:NULL];
    if (success) {
        [self hd_removeObserver:self.hd_delegate forKeyPath:keyPath];
    }
}



@end
