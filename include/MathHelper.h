//
//  MathHelper.h
//  Utilities
//
//  Created by Goffredo Marocchi on 12/6/10.
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

#import <Foundation/Foundation.h>
#import "GeneralDefines.h"
#import "GraphicsDefines.h"

#ifndef MATHHELPER_H_
#define MATHHELPER_H_

#ifndef ARC4RANDOM_MAX
#define ARC4RANDOM_MAX      (0x100000000)
#endif

//PRAGMA MARK: static convenience methods -->
CG_EXTERN int rangeRNGi(int min, int max);
CG_EXTERN CGFloat lerpRanges (CGFloat value, CGFloat minLeft, CGFloat maxLeft, CGFloat minRight, CGFloat maxRight);

CG_EXTERN CGFloat lerp(CGFloat ft, CGFloat f0, CGFloat f1);
CG_EXTERN CGFloat funcQuad(CGFloat ft, CGFloat f0, CGFloat f1);

CG_EXTERN CGFloat funcPower(CGFloat ft, CGFloat f0, CGFloat f1, CGFloat p);
CG_EXTERN Vertex2f Vertex2fMake(CGFloat inX, CGFloat inY);

CG_EXTERN void Vertex2fSet(Vertex2f *vertex, CGFloat inX, CGFloat inY);

CG_EXTERN Vertex2ui Vertex2uiMake(u_int inX, u_int inY);

CG_EXTERN void Vertex2uiSet(Vertex2ui *vertex, u_int inX, u_int inY);

CG_EXTERN Vector2f Vector2fMake(CGFloat inX, CGFloat inY);

CG_EXTERN Vector2ui Vector2uiMake(u_int inX, u_int inY);

CG_EXTERN Vertex3f Vertex3fMake(CGFloat inX, CGFloat inY, CGFloat inZ);

CG_EXTERN void Vertex3fSet(Vertex3f *vertex, CGFloat inX, CGFloat inY, CGFloat inZ);

CG_EXTERN Vertex3ui Vertex3uiMake(u_int inX, u_int inY, u_int inZ);

CG_EXTERN void Vertex3uiSet(Vertex3ui *vertex, u_int inX, u_int inY, u_int inZ);
CG_EXTERN Vector3f Vector3fMake(CGFloat inX, CGFloat inY, CGFloat inZ);

CG_EXTERN Vector3ui Vector3uiMake(u_int inX, u_int inY, u_int inZ);

CG_EXTERN Color4b Color4bMake(u_char inR, u_char inG, u_char inB, u_char inA);

CG_EXTERN float findAngleBetweenVectors(CGPoint v1,CGPoint v2);

CG_EXTERN void QuadToTrianglesWindCWSet(u_short *vertex, CGFloat ul, CGFloat ur, CGFloat ll, CGFloat lr);

CG_EXTERN void QuadToTrianglesWindCCWSet(u_short *vertex, CGFloat ul, CGFloat ur, CGFloat ll, CGFloat lr);


CG_EXTERN void vec2Diff( vec2 *_v1, vec2 *_v2, vec2 *_v3 );

CG_EXTERN void vec3Add( vec3 *_v1, vec3 *_v2, vec3 *_v3 );

CG_EXTERN void vec3Diff( vec3 *_v1, vec3 *_v2, vec3 *_v3 );

CG_EXTERN float magnitude( vec3 *_v1 );

CG_EXTERN float distance( vec3 *_v1, vec3 *_v2 );

CG_EXTERN float normalize( vec3 *_v1, vec3 *_v2 );

CG_EXTERN float dotProduct( vec3 *_v1, vec3 *_v2 );

CG_EXTERN float dotProductToDeg( vec3 *_v1, vec3 *_v2 );

CG_EXTERN void crossProduct( vec3 *_v1, vec3 *_v2, vec3 *_v3 );

CG_EXTERN char projectToScreen ( float objx,
									float objy,
									float objz,
									float model   [ 16 ],
									float proj    [ 16 ],
									int   viewport[ 4  ],
									float *winx,
									float *winy,
									float *winz );
#endif

@interface MathHelper : NSObject {

}

+ (CGFloat) lerpRangesValue:(CGFloat)value minOrigRange:(CGFloat)minLeft maxOrigRange:(CGFloat)maxLeft 
				minNewRange:(CGFloat)minRight maxNewRange:(CGFloat)maxRight;



@end
