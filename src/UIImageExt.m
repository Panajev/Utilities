//
//  UIImageExt.m
//  Utilities
//
//  Created by Goffredo Marocchi on 12/2/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import "UIImageExt.h"

@implementation UIImage(UIImageExt)
- (void)drawInRect:(CGRect)drawRect fromRect:(CGRect)fromRect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha 
{
    CGImageRef drawImage = CGImageCreateWithImageInRect(self.CGImage, fromRect); 
    if (drawImage != NULL)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Push current graphics state so we can restore later
        CGContextSaveGState(context);   
        
        // Set the alpha and blend based on passed in settings
        CGContextSetBlendMode(context, blendMode);
        CGContextSetAlpha(context, alpha);
        
        // Take care of Y-axis inversion problem by translating the context on the y axis
        CGContextTranslateCTM(context, 0, drawRect.origin.y + fromRect.size.height);  
        
        // Scaling -1.0 on y-axis to flip
        CGContextScaleCTM(context, 1.0, -1.0);
        
        // Then accommodate the translate by adjusting the draw rect
        drawRect.origin.y = 0.0f;
        
        // Draw the image
        CGContextDrawImage(context, drawRect, drawImage);
        
        // Clean up memory and restore previous state
        CGImageRelease(drawImage);
        
        // Restore previous graphics state to what it was before we tweaked it
        CGContextRestoreGState(context); 
    }
}
@end