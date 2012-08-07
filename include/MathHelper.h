//
//  MathHelper.h
//  Utilities
//
//  Created by Goffredo Marocchi on 12/6/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

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
