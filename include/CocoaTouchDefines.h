//
//  CocoaTouchDefines.h
//  Utilities
//
//  Created by Goffredo Marocchi on 5/29/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#ifndef COCOATOUCHDEFINES_H
#define COCOATOUCHDEFINES_H

////////////////////////////
//UIColor///////////////////
////////////////////////////
//UIColor components are defined [0,1]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
/*
 * CGColorRef CGColorValue = [myUIColor CGColor];
 * const CGFloat *componentColors = CGColorGetComponents(CGColorValue);
 *
 * red is	componentColors[0];
 * green is componentColors[1];
 * blue is	componentColors[2];
 * alpha is componentColors[3];
 */
#endif /*COCOATOUCHDEFINES_H*/