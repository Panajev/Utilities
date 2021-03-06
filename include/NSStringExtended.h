//
//  NSStringExtended.h
//  WapTool
//
//  Created by Goffredo Marocchi on 1/20/10.
//  Copyright 2010 AddictiveColors. All rights reserved.
//

//portions of this file have been created thanks to the following work:
/*Copyright (c) 2008, Rob Ellis, Brock Whitten, Brian Leroux, Joe Bowser, Dave Johnson, Nitobi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
 (the "Software"), to deal in the Software without restriction, 
 including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
 
#import <Foundation/Foundation.h>

#if __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>
#import <libxml/tree.h>
#endif

#if __CC_PLATFORM_MAC
#import <AppKit/AppKit.h>
#endif

@interface NSString (HexColor)

#if __CC_PLATFORM_IOS
- (UIColor *)colorFromHex;
- (const xmlChar *)xmlChar;
- (NSString *)trimWhitespace;
#endif

#if __CC_PLATFORM_MAC

#endif

@end




