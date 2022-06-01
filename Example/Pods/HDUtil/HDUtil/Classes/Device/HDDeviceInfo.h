//
//  HDDeviceInfo.h
//  Pods
//
//  Created by 黄山锋 on 2022/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 系统版本
#define HDSysVersion                             [[UIDevice currentDevice] systemVersion]
// =
#define HDSysVersionIsEqualTo(v)                 ([HDSysVersion compare:v options:NSNumericSearch] == NSOrderedSame)
// >
#define HDSysVersionIsGreaterThan(v)             ([HDSysVersion compare:v options:NSNumericSearch] == NSOrderedDescending)
// >=
#define HDSysVersionIsGreaterThanOrEqualTo(v)    ([HDSysVersion compare:v options:NSNumericSearch] != NSOrderedAscending)
// <
#define HDSysVersionIsLessThan(v)                ([HDSysVersion compare:v options:NSNumericSearch] == NSOrderedAscending)
// <=
#define HDSysVersionIsLessThanOrEqualTo(v)       ([HDSysVersion compare:v options:NSNumericSearch] != NSOrderedDescending)

#define HDDeviceIdentifier      [HDDeviceInfo deviceIdentifier]
#define HDDeviceType            [HDDeviceInfo deviceType]
#define HDIsIPad                [HDDeviceInfo isIPad]
#define HDIsIPhone              [HDDeviceInfo isIPhone]
#define HDIsIPhoneX             [HDDeviceInfo isIPhoneX]

#define HDKeyWindow             [HDDeviceInfo keyWindow]
#define HDScreenScale           [HDDeviceInfo scaleOfScreen]
#define HDScreenSize            [HDDeviceInfo screenSize]
#define HDScreenWidth           [HDDeviceInfo screenWidth]
#define HDScreenHeight          [HDDeviceInfo screenHeight]
#define HDStatusBarHeight       [HDDeviceInfo statusBarHeight]
#define HDSafeAreaInsets        [HDDeviceInfo safeAreaInsets]
#define HDNavBarHeight          44.0                                 //导航栏高度
#define HDTopHeight             (HDStatusBarHeight + HDNavBarHeight) // 导航栏+状态栏的高度
#define HDSafeBottomHeight      (HDStatusBarHeight > 20 ? 34 : 0)    // 底部安全高度
#define HDTabBarHeight          49.0                                 // tabBar的高度
#define HDBottomHeight          (HDSafeBottomHeight+HDTabBarHeight)  // tabBar+底部安全的高度

@interface HDDeviceInfo : NSObject

#pragma mark - Device

/// 获取设备标识
/// https://www.theiphonewiki.com/wiki/Models#iPhone
+ (NSString *)deviceIdentifier;

/// 手机型号
+ (NSString *)deviceType;

/// 是否iPad机型
+ (BOOL)isIPad;

/// 是否iPhone机型
+ (BOOL)isIPhone;

/// 是否iPhoneX系列机型
+ (BOOL)isIPhoneX;



#pragma mark - Screen

/// keyWindow
+ (UIWindow *)keyWindow;

/// 屏幕缩放比例
+ (CGFloat)scaleOfScreen;

/// 屏幕尺寸
+ (CGSize)screenSize;

/// 屏幕宽度
+ (CGFloat)screenWidth;

/// 屏幕高度
+ (CGFloat)screenHeight;

/// 状态栏高度
+ (CGFloat)statusBarHeight;

/// 安全间距
+ (UIEdgeInsets)safeAreaInsets;


@end

NS_ASSUME_NONNULL_END


