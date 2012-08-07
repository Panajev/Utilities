//
//  CocoaTouchDefines.h
//  Utilities
//
//  Created by Goffredo Marocchi on 5/29/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

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
