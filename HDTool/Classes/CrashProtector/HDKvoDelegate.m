//
//  HDKvoDelegate.m
//  HDTool
//
//  Created by 黄山锋 on 2022/6/1.
//

#import "HDKvoDelegate.h"
#import "HDCrashReceiver.h"

@interface HDKvoDelegate ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableSet<HDKvoInfo *> *> *kvoInfoMap;
@end

@implementation HDKvoDelegate
- (NSMutableDictionary<NSString *,NSMutableSet<HDKvoInfo *> *> *)kvoInfoMap {
    if (!_kvoInfoMap) {
        _kvoInfoMap = [NSMutableDictionary dictionary];
    }
    return _kvoInfoMap;
}
- (BOOL)addKvoInfoToMapsWithObserver:(NSObject *)observer
                          forKeyPath:(NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(nullable void *)context {
    @synchronized (self) {
        HDKvoInfo *info = [HDKvoInfo infoWithObserver:observer forKeyPath:keyPath options:options context:context];
        if (!info) {
            return NO;
        }
        NSMutableSet<HDKvoInfo *> *infoSet = [self getSafeInfoSetWithKeyPath:keyPath];
        BOOL isExist = NO;
        for (HDKvoInfo *i in infoSet) {
            if ([info isEqual:i]) {
                isExist = YES;
                break;
            }
        }
        if (isExist) {
            NSString *info = [NSString stringWithFormat:@"重复添加: \n observer:%@ \n keyPath:%@\n options:%lu \n context:%@", observer, keyPath, (unsigned long)options, context];
            [HDCrashReceiver printCrashLogWithObj:self.observed aSelector:@selector(addObserver:forKeyPath:options:context:) isMetaClass:NO title:@"KVO" info:info];
            return NO;
        }else{
            [infoSet addObject:info];
            self.kvoInfoMap[keyPath] = infoSet;
            return YES;
        }
    }
}
- (BOOL)removeKvoInfoToMapsWithObserver:(NSObject *)observer
                             forKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context {
    @synchronized (self) {
        HDKvoInfo *info = [HDKvoInfo infoWithObserver:observer forKeyPath:keyPath options:options context:context];
        if (!info) {
            return NO;
        }
        NSMutableSet<HDKvoInfo *> *infoSet = [self getSafeInfoSetWithKeyPath:keyPath];
        BOOL isExist = NO;
        for (HDKvoInfo *i in infoSet) {
            if ([info isEqual:i]) {
                isExist = YES;
                break;
            }
        }
        if (isExist) {
            [infoSet removeObject:info];
            self.kvoInfoMap[keyPath] = infoSet;
            return YES;
        }else{
            NSString *info = [NSString stringWithFormat:@"重复移出: \n observer:%@ \n keyPath:%@\n options:%lu \n context:%@", observer, keyPath, (unsigned long)options, context];
            [HDCrashReceiver printCrashLogWithObj:self.observed aSelector:@selector(removeObserver:forKeyPath:context:) isMetaClass:NO title:@"KVO" info:info];
            return NO;
        }
    }
}

- (NSSet<HDKvoInfo *> *)getInfoSetWithObserver:(NSObject *)observer {
    NSMutableSet<HDKvoInfo *> *set = [NSMutableSet set];
    for (NSMutableSet<HDKvoInfo *> * infoSet in self.kvoInfoMap.allValues) {
        for (HDKvoInfo *info in infoSet) {
            if ([info.observer isEqual:observer]) {
                [set addObject:info];
            }
        }
    }
    return set.copy;
}

- (NSSet<HDKvoInfo *> *)getAllInfoSet {
    NSMutableSet<HDKvoInfo *> *set = [NSMutableSet set];
    for (NSMutableSet<HDKvoInfo *> * infoSet in self.kvoInfoMap.allValues) {
        for (HDKvoInfo *info in infoSet) {
            [set addObject:info];
        }
    }
    return set.copy;
}

- (NSMutableSet<HDKvoInfo *> *)getSafeInfoSetWithKeyPath:(NSString *)keyPath {
    NSMutableSet<HDKvoInfo *> *infoSet;
    if ([self.kvoInfoMap.allKeys containsObject:keyPath]) {
        infoSet = self.kvoInfoMap[keyPath];
    }else{
        infoSet = [NSMutableSet set];
        self.kvoInfoMap[keyPath] = infoSet;
    }
    return infoSet;
}

#pragma mark - kvo回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context {
    NSObject *observed = (NSObject *)object;
    NSSet<HDKvoInfo *> *infoSet = self.kvoInfoMap[keyPath];
    NSMutableSet<HDKvoInfo *> *infoSetSafe = [NSMutableSet set];
    for (HDKvoInfo *info in infoSet) {
        if (info.observer) {
            [infoSetSafe addObject:info];
        }else{
            // observer已经为nil，所以需要移除被观察者observed 和 当前观察者之间注册的所有KVO
            [observed removeObserver:self forKeyPath:info.keyPath context:info.context];
        }
    }
    self.kvoInfoMap[keyPath] = infoSetSafe;
    for (HDKvoInfo *info in infoSetSafe) {
        @try {
            [info.observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        } @catch (NSException *exception) {
            NSString *info = [NSString stringWithFormat:@"代理转发kvo回调失败: \n keyPath:%@ \n object:%@\n change:%@ \n context:%@", keyPath, object, change, context];
            [HDCrashReceiver printCrashLogWithObj:self.observed aSelector:@selector(observeValueForKeyPath:ofObject:change:context:) isMetaClass:NO title:@"KVO" info:info];
        }
    }
}
@end
