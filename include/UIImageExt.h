//
//  UIImageExt.h
//  Utilities
//
//  Created by Goffredo Marocchi on 12/2/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#if IPHONE_SDK_PROJECT==1
#import <UIKit/UIKit.h>

@interface UIImage (UIImageExt)

- (void)drawInRect:(CGRect)drawRect fromRect:(CGRect)fromRect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end

#endif

#if OSX_PROJECT==1
#import <AppKit/AppKit.h>
#endif
