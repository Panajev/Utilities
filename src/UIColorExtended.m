//
//  UIColorExtended.m
//  WapTool
//
//  Created by Goffredo Marocchi on 1/20/10.
//  Copyright 2010 AddictiveColors. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
//  following conditions are met:
//
//      Redistributions of source code must retain the above copyright notice, this list of conditions and the following
//      disclaimer.
//      Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
//      disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIColorExtended.h"
#import "SysTools.h"

#ifdef __CC_PLATFORM_IOS

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