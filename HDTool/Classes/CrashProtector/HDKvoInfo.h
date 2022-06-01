//
//  HDKvoInfo.h
//  HDTool
//
//  Created by 黄山锋 on 2022/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
options参数说明:
NSKeyValueObservingOptionNew 拿到新值
NSKeyValueObservingOptionOld 拿到旧值
NSKeyValueObservingOptionInitial 注册就会发一下通知,改变后还会发
NSKeyValueObservingOptionPrior 改变之前发一次,改变后发一次
*/

@interface HDKvoInfo : NSObject
@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, assign) NSKeyValueObservingOptions options;
@property (nonatomic) void *context;
+ (instancetype)infoWithObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end

NS_ASSUME_NONNULL_END
