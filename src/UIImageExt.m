//
//  UIImageExt.m
//  Utilities
//
//  Created by Goffredo Marocchi on 12/2/10.
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

#ifdef __CC_PLATFORM_IOS
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

#endif