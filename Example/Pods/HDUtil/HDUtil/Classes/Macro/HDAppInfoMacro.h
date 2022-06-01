//
//  HDAppInfoMacro.h
//  Pods
//
//  Created by 黄山锋 on 2022/5/19.
//

#ifndef HDAppInfoMacro_h
#define HDAppInfoMacro_h


//APP的名称
#define HDAppName                [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//APP版本号
#define HDAppVersion_short       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//APP bulid版本
#define HDAppVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//APP bundle id
#define HDAppBundleID            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
//系统版本号
#define HDAppSystemVersion       [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define HDAppCurrentLanguage     ([[NSLocale preferredLanguages] objectAtIndex:0])


#define HDApplication            [UIApplication sharedApplication]
#define HDAppDelegate            (AppDelegate *)HDApplication.delegate
#define HDUserDefaults           [NSUserDefaults standardUserDefaults]
#define HDNotificationCenter     [NSNotificationCenter defaultCenter]



#endif /* HDAppInfoMacro_h */
