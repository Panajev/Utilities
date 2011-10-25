//
//  UIColorExtended.h
//  WapTool
//
//  Created by Goffredo Marocchi on 1/20/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#if IPHONE_SDK_PROJECT==1
#import <UIKit/UIKit.h>

@interface UIColor (UIColorExtended)

+(UIColor *) randomColorRGB;
+(UIColor *) randomColorRGBA;
@end

#endif

#if OSX_PROJECT==1
#import <AppKit/AppKit.h>
#endif




