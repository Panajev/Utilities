//
//  CoreGraphicsExt.h
//  Utilities
//
//  Created by Goffredo Marocchi on 11/12/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#define SAFE_CGIMAGE_RELEASE(temp)  do{CGImageRelease(temp); temp = NULL;}while(0)
#define SAFE_CGCONTEXT_RELEASE(temp)  do{CGContextRelease(temp); temp = NULL;}while(0)
#define SAFE_CGDATAPROVIDER_RELEASE(temp)  do{CGDataProviderRelease(temp); temp = NULL;}while(0)
#define SAFE_CGCOLORSPACE_RELEASE(temp)  do{CGColorSpaceRelease(temp); temp = NULL;}while(0)

#ifndef COREGRAPHICSEXT_H_
#define COREGRAPHICSEXT_H_

CG_EXTERN BOOL CGCircleContainsPoint (CGFloat circleRadius, CGPoint origin, CGPoint p);
CG_EXTERN CGFloat CGAngleDifference(float angleA, float angleB);
CG_EXTERN CGFloat CGVectorToRadians(CGPoint vector);
CG_EXTERN CGPoint CGRadiansToVector(float radians);

CG_EXTERN CGPoint CGVectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CG_EXTERN CGFloat CGDistanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CG_EXTERN CGFloat CGAngleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);
CG_EXTERN CGFloat CGAngleBetweenCGLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End);
CG_EXTERN CGFloat CGAngleWithXaxis(CGPoint line1Start, CGPoint line1End);

#endif //COREGRAPHICSEXT_H_