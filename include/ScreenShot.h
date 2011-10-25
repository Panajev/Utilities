#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 Copyright (c) 2010 Aral Balkan. Released under the open source MIT license.
 
 Based on the sample Apple code at
 http://developer.apple.com/library/ios/#qa/qa2010/qa1703.html
 */

#if IPHONE_SDK_PROJECT==1
@interface UIScreen(Screenshot)

+ (UIImage*)screenshot;
+ (UIImage *)keyboardScreenshot;
+ (UIWindow*)keyboardRef;
@end
#endif

