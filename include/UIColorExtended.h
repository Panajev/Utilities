//
//  UIColorExtended.h
//  WapTool
//
//  Created by Goffredo Marocchi on 1/20/10.
//  Copyright 2010 IGGS. All rights reserved.
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
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




