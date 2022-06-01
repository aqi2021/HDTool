#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HDTool.h"
#import "HDCrashProtector.h"
#import "HDCrashReceiver.h"
#import "HDKvoDelegate.h"
#import "HDKvoInfo.h"
#import "NSObject+HDKvcCrash.h"
#import "NSObject+HDKvoCrash.h"
#import "NSObject+HDSelectorCrash.h"
#import "HDLogger.h"

FOUNDATION_EXPORT double HDToolVersionNumber;
FOUNDATION_EXPORT const unsigned char HDToolVersionString[];

