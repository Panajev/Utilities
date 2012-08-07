//
//  NSStringExtended.m
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

#import "NSStringExtended.h"

// Created by Michael Nachbaur on 08/05/09.
// Copyright 2009 Decaf Ninja Software. All rights reserved.
//


@implementation NSString (HexColor)

#if IPHONE_SDK_PROJECT==1

- (UIColor *)colorFromHex
{
    NSString *hexColor = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
    if ([hexColor length] < 6)
        return [UIColor blackColor];
    if ([hexColor hasPrefix:@"#"])
        hexColor = [hexColor substringFromIndex:1];
    if ([hexColor length] != 6 && [hexColor length] != 8)
        return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [hexColor substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    range.location = 6;
    NSString *aString = @"FF";
    if ([hexColor length] == 8)
        aString = [hexColor substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}

- (const xmlChar *)xmlChar
{
	return (const xmlChar *)[self UTF8String];
}

- (NSString *)trimWhitespace
{
	NSMutableString *mStr = [self mutableCopy];
	CFStringTrimWhitespace((__bridge CFMutableStringRef)mStr);
	
	NSString *result = [mStr copy];
	
	return result;
}
#endif

#if OSX_PROJECT==1
#import <AppKit/AppKit.h>


#endif

@end


