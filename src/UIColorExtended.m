//
//  UIColorExtended.m
//  WapTool
//
//  Created by Goffredo Marocchi on 1/20/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import "UIColorExtended.h"
#import "SysTools.h"

#if IPHONE_SDK_PROJECT==1

@implementation UIColor (UIColorExtended)

+(UIColor *) randomColorRGB {
	
	CGFloat r,g,b;

	r = (CGFloat)[SysTools randomInt:0 peak:255];
	g = (CGFloat)[SysTools randomInt:0 peak:255];
	b = (CGFloat)[SysTools randomInt:0 peak:255];
	return RGB(r,g,b);
	
}

+(UIColor *) randomColorRGBA {
	
	CGFloat r,g,b,a;
	
	r = (CGFloat)[SysTools randomInt:0 peak:255];
	g = (CGFloat)[SysTools randomInt:0 peak:255];
	b = (CGFloat)[SysTools randomInt:0 peak:255];
	a = (CGFloat)[SysTools randomInt:0 peak:255];
	return (RGBA(r,g,b,a));
	
}

@end

#else

#endif