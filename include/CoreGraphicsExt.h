//
//  CoreGraphicsExt.h
//  Utilities
//
//  Created by Goffredo Marocchi on 11/12/10.
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

#import <CoreGraphics/CoreGraphics.h>

#define SAFE_CGIMAGE_RELEASE(temp)  do{CGImageRelease(temp); temp = NULL;}while(0)
#define SAFE_CGCONTEXT_RELEASE(temp)  do{CGContextRelease(temp); temp = NULL;}while(0)
#define SAFE_CGDATAPROVIDER_RELEASE(temp)  do{CGDataProviderRelease(temp); temp = NULL;}while(0)
#define SAFE_CGCOLORSPACE_RELEASE(temp)  do{CGColorSpaceRelease(temp); temp = NULL;}while(0)

#ifndef COREGRAPHICSEXT_H_
#define COREGRAPHICSEXT_H_

CG_EXTERN BOOL CGCircleContainsPoint (CGFloat circleRadius, CGPoint origin, CGPoint p);
CG_EXTERN CGFloat CGAngleDifference(CGFloat angleA, CGFloat angleB);
CG_EXTERN CGFloat CGVectorToRadians(CGPoint vector);
CG_EXTERN CGPoint CGRadiansToVector(CGFloat radians);

CG_EXTERN CGPoint CGVectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CG_EXTERN CGFloat CGDistanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CG_EXTERN CGFloat CGAngleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);
CG_EXTERN CGFloat CGAngleBetweenCGLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End);
CG_EXTERN CGFloat CGAngleWithXaxis(CGPoint line1Start, CGPoint line1End);

#endif //COREGRAPHICSEXT_H_
