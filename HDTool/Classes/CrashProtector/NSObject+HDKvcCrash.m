//
//  NSObject+HDKvcCrash.m
//  HDTool
//
//  Created by 黄山锋 on 2022/5/24.
//

#import "NSObject+HDKvcCrash.h"
#import "HDCrashReceiver.h"
#import <HDCategory/HDCategory.h>

@implementation NSObject (HDKvcCrash)

+ (void)hd_openKvcCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject hd_swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(setValue:forKey:) swizzledMethod:@selector(hd_setValue:forKey:)];  
    });
}

- (void)hd_setValue:(id)value forKey:(NSString *)key {
    if (!key) {
        NSString *info = @"attempt to set a value for a nil key";
        [HDCrashReceiver printCrashLogWithObj:self aSelector:_cmd isMetaClass:NO title:@"KVC" info:info];
        return;
    }
    [self hd_setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSString *info = [NSString stringWithFormat:@"this class is not key value coding-compliant for the key: %@,value:%@'",key ,value];
    [HDCrashReceiver printCrashLogWithObj:self aSelector:_cmd isMetaClass:NO title:@"KVC" info:info];
}

- (nullable id)valueForUndefinedKey:(NSString *)key {
    NSString *info = [NSString stringWithFormat:@"this class is not key value coding-compliant for the key: %@",key];
    [HDCrashReceiver printCrashLogWithObj:self aSelector:_cmd isMetaClass:NO title:@"KVC" info:info];
    return self;
}

- (void)setNilValueForKey:(NSString *)key {
    NSString *info = [NSString stringWithFormat:@"could not set nil as the value for the key '%@'", key];
    [HDCrashReceiver printCrashLogWithObj:self aSelector:_cmd isMetaClass:NO title:@"KVC" info:info];
}



@end
