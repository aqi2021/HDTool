//
//  HDKvoDelegate.h
//  HDTool
//
//  Created by 黄山锋 on 2022/6/1.
//

#import <Foundation/Foundation.h>
#import "HDKvoInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface HDKvoDelegate : NSObject
@property (nonatomic, weak) NSObject *observed;// 被观察者
- (BOOL)addKvoInfoToMapsWithObserver:(NSObject *)observer
                          forKeyPath:(NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(nullable void *)context;
- (BOOL)removeKvoInfoToMapsWithObserver:(NSObject *)observer
                             forKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context;
- (NSSet<HDKvoInfo *> *)getInfoSetWithObserver:(NSObject *)observer;
@end

NS_ASSUME_NONNULL_END
