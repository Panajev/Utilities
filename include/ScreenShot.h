#import <Foundation/Foundation.h>

/*
 Copyright (c) 2010 Aral Balkan. Released under the open source MIT license.
 
 Based on the sample Apple code at
 http://developer.apple.com/library/ios/#qa/qa2010/qa1703.html
 */

#ifdef __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>

@interface UIScreen(Screenshot)

+ (UIImage*)screenshot;
+ (UIImage *)keyboardScreenshot;
+ (UIWindow*)keyboardRef;
@end

#else
#import <AppKit/AppKit.h>


#endif

