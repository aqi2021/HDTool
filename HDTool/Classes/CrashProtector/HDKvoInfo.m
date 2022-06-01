//
//  HDKvoInfo.m
//  HDTool
//
//  Created by 黄山锋 on 2022/6/1.
//

#import "HDKvoInfo.h"

@implementation HDKvoInfo
+ (instancetype)infoWithObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    HDKvoInfo *info = [[HDKvoInfo alloc]init];
    info.observer = observer;
    info.keyPath = keyPath;
    info.options = options;
    info.context = context;
    return info;
}
- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[HDKvoInfo class]]) {
        HDKvoInfo *info = (HDKvoInfo *)object;
        BOOL same = [info.observer isEqual:self.observer] && [info.keyPath isEqualToString:self.keyPath];
        return same;
    }
    return NO;
}

@end
