//
//  ScreenShot.m
//  Utilities
//
//  Created by Goffredo Marocchi on 10/19/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import "ScreenShot.h"
#import <QuartzCore/QuartzCore.h>

#if IPHONE_SDK_PROJECT==1

@implementation UIScreen(Screenshot)

+ (UIImage *)screenshot
{
	// Also checking for version directly for 3.2(.x) since UIGraphicsBeginImageContextWithOptions appears to exist
	// but can't be used.
	float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
	
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
	CGSize imageSize = [[UIScreen mainScreen] bounds].size;
	if (systemVersion >= 4.0f)
	{
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
		
	} else {
		UIGraphicsBeginImageContext(imageSize);
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Iterate over every window from back to front
	//NSInteger count = 0;
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
	{
		if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
		{
			// -renderInContext: renders in the coordinate space of the layer,
			// so we must first apply the layer's geometry to the graphics context
			CGContextSaveGState(context);
			// Center the context around the window's anchor point
			CGContextTranslateCTM(context, [window center].x, [window center].y);
			// Apply the window's transform about the anchor point
			CGContextConcatCTM(context, [window transform]);
			
			// Y-offset for the status bar (if it's showing)
			NSInteger yOffset = [UIApplication sharedApplication].statusBarHidden ? 0 : -20;
			
			// Offset by the portion of the bounds left of and above the anchor point
			CGContextTranslateCTM(context,
								  -[window bounds].size.width * [[window layer] anchorPoint].x,
								  -[window bounds].size.height * [[window layer] anchorPoint].y + yOffset);
			
			// Render the layer hierarchy to the current context
			[[window layer] renderInContext:context];
			
			// Restore the context
			CGContextRestoreGState(context);
		}
	}
	
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return image;
}

+ (UIWindow*)keyboardRef
{
	UIWindow *keyboard = nil;
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
	{
		if ([[window description] hasPrefix:@"<UITextEffectsWin"])
		{
			keyboard = window;
			break;
		}
	}
	return keyboard;
}

+ (UIImage *)keyboardScreenshot
{
	// Also checking for version directly for 3.2(.x) since UIGraphicsBeginImageContextWithOptions appears to exist
	// but can't be used.
	float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
	
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
	CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (systemVersion >= 4.0f)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
	else
		UIGraphicsBeginImageContext(imageSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Iterate over every window from back to front
	//NSInteger count = 0;
	UIWindow *window = [UIScreen keyboardRef];
	
	// -renderInContext: renders in the coordinate space of the layer,
	// so we must first apply the layer's geometry to the graphics context
	CGContextSaveGState(context);
	// Center the context around the window's anchor point
	CGContextTranslateCTM(context, [window center].x, [window center].y);
	// Apply the window's transform about the anchor point
	CGContextConcatCTM(context, [window transform]);
	
	// Y-offset for the status bar (if it's showing)
	NSInteger yOffset = [UIApplication sharedApplication].statusBarHidden ? 0 : -20;
	
	// Offset by the portion of the bounds left of and above the anchor point
	CGContextTranslateCTM(context,
						  -[window bounds].size.width * [[window layer] anchorPoint].x,
						  -[window bounds].size.height * [[window layer] anchorPoint].y + yOffset );
	
	// Render the layer hierarchy to the current context
	[[window layer] renderInContext:context];
	
	// Restore the context
	CGContextRestoreGState(context);
	
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return image;
}
#endif

@end