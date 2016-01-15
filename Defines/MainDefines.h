//
//  MainDefines.h
//  RunTimeDemo
//
//  Created by Xwj on 16/1/15.
//  Copyright © 2016年 Xwj. All rights reserved.
//

#ifndef MainDefines_h
#define MainDefines_h

//16进制颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//图片
#define ImageNamed(_pointer) [UIImage imageNamed:(_pointer)]

//单例声明  实例化
#undef	AS_SINGLETION
#define AS_SINGLETION( __class ) \
+ (__class *)shared##__class

#undef	DEF_SINGLETION
#define DEF_SINGLETION( __class ) \
+ (__class *)shared##__class \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//debuglog
#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:%d (%@)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

//根据tag取view
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

//设备当前的版本
#define IOS_Version [[UIDevice currentDevice].systemVersion doubleValue]

//屏幕宽度和高度
#define MAINWIDTH [[UIScreen mainScreen] bounds].size.width
#define MAINHEIGHT [[UIScreen mainScreen] bounds].size.height

#endif /* MainDefines_h */
