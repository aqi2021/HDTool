
//
//  HDDeviceInfo.m
//  Pods
//
//  Created by 黄山锋 on 2022/5/19.
//

#import "HDDeviceInfo.h"
#import <sys/utsname.h>

@implementation HDDeviceInfo

#pragma mark - Device

/// 获取设备标识
/// https://www.theiphonewiki.com/wiki/Models#iPhone
+ (NSString *)deviceIdentifier {
    static NSString *identifier;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        identifier = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    });
    return identifier;
}

/// 手机型号
+ (NSString *)deviceType {
    NSString *identifier = [self deviceIdentifier];
    
    // simulator 模拟器
    if ([identifier isEqualToString:@"i386"])   return @"Simulator";
    if ([identifier isEqualToString:@"x86_64"])  return @"Simulator";
    
    // iPhone
    if ([identifier isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    if ([identifier isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    if ([identifier isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    if ([identifier isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    if ([identifier isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    if ([identifier isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    if ([identifier isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    if ([identifier isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    if ([identifier isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    if ([identifier isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    if ([identifier isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    if ([identifier isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    if ([identifier isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    if ([identifier isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    if ([identifier isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    if ([identifier isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    if ([identifier isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    if ([identifier isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    if ([identifier isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    if ([identifier isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    if ([identifier isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([identifier isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([identifier isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([identifier isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([identifier isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([identifier isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([identifier isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([identifier isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([identifier isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([identifier isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([identifier isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([identifier isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([identifier isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([identifier isEqualToString:@"iPhone12,8"]) return @"iPhone SE2";
    if ([identifier isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([identifier isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([identifier isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([identifier isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([identifier isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([identifier isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([identifier isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([identifier isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    if ([identifier isEqualToString:@"iPhone14,6"]) return @"iPhone SE (3rd generation)";
    
    // iPad
    
    return identifier;
}

/// 是否iPad机型
+ (BOOL)isIPad {
//    NSString *identifier = [self deviceIdentifier];
//    return [identifier hasPrefix:@"iPad"];
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

/// 是否iPhone机型
+ (BOOL)isIPhone {
//    NSString *identifier = [self deviceIdentifier];
//    return [identifier hasPrefix:@"iPhone"];
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

/// 是否iPhoneX系列机型
+ (BOOL)isIPhoneX {
    CGFloat bottom = [self safeAreaInsets].bottom;
    return [self isIPhone] && (bottom > 0.0);
}


#pragma mark - Screen

/// keyWindow
+ (UIWindow *)keyWindow {
    UIWindow* window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.lastObject;
                break;
            }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

/// 屏幕缩放比例
+ (CGFloat)scaleOfScreen {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

/// 屏幕尺寸
+ (CGSize)screenSize {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

/// 屏幕宽度
+ (CGFloat)screenWidth {
    return [self screenSize].width;
}

/// 屏幕高度
+ (CGFloat)screenHeight {
    return [self screenSize].height;
}

/// 状态栏高度
+ (CGFloat)statusBarHeight {
    static CGFloat height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 13.0, *)) {
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
            height = statusBarManager.statusBarFrame.size.height;
        }
        else {
            height = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    });
    return height;
}

/// 安全间距
+ (UIEdgeInsets)safeAreaInsets {
    static UIEdgeInsets insert;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            insert = [self keyWindow].safeAreaInsets;
        }
        else {
            insert = UIEdgeInsetsZero;
        }
    });
    return insert;
}

@end
