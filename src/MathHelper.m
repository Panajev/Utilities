//
//  MathHelper.m
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

#import "MathHelper.h"

int rangeRNGi(int min, int max){ 
    return (arc4random()%max)+min;
}

float rangeRNGf(float max) {
    return (floorf(((double)arc4random() / ARC4RANDOM_MAX) * max));
}

CGFloat lerpRanges (CGFloat value, CGFloat minLeft, CGFloat maxLeft, CGFloat minRight, CGFloat maxRight) {
	CGFloat leftRangeDelta = maxLeft - minLeft; //screenResolution for example
	CGFloat rightRangeDelta = maxRight - minRight; //local GL view position for example
	CGFloat scaleFactorRange = rightRangeDelta / leftRangeDelta;
	return ( ((value - minLeft)*scaleFactorRange) + minRight );
}

CGFloat lerp(CGFloat ft, CGFloat f0, CGFloat f1)
{
	// Linear interpolation between f0 and f1
	return f0 + (f1 - f0) * ft;	
}

CGFloat funcQuad(CGFloat ft, CGFloat f0, CGFloat f1)
{
	// Quadratic interpolation between f0 and f1
	return f0 + (f1 - f0) * ft * ft;	
}

CGFloat funcPower(CGFloat ft, CGFloat f0, CGFloat f1, CGFloat p)
{
	// Exponential interpolation between f0 and f1
	return f0 + (f1 - f0) * pow(ft, p);
}
Vertex2f Vertex2fMake(CGFloat inX, CGFloat inY)
{
	Vertex2f ret;
	ret.x = inX;
	ret.y = inY;
	return ret;
}

void Vertex2fSet(Vertex2f *vertex, CGFloat inX, CGFloat inY)
{
	vertex->x = inX;
	vertex->y = inY;
}

Vertex2ui Vertex2uiMake(u_int inX, u_int inY)
{
	Vertex2ui ret;
	ret.x = inX;
	ret.y = inY;
	return ret;
}

void Vertex2uiSet(Vertex2ui *vertex, u_int inX, u_int inY)
{
	vertex->x = inX;
	vertex->y = inY;
}

Vector2f Vector2fMake(CGFloat inX, CGFloat inY)
{
	Vector2f ret;
	ret.x = inX;
	ret.y = inY;
	return ret;
}

Vector2ui Vector2uiMake(u_int inX, u_int inY)
{
	Vector2ui ret;
	ret.x = inX;
	ret.y = inY;
	return ret;
}

Vertex3f Vertex3fMake(CGFloat inX, CGFloat inY, CGFloat inZ)
{
	Vertex3f ret;
	ret.x = inX;
	ret.y = inY;
	ret.z = inZ;
	return ret;
}

void Vertex3fSet(Vertex3f *vertex, CGFloat inX, CGFloat inY, CGFloat inZ)
{
	vertex->x = inX;
	vertex->y = inY;
	vertex->z = inZ;
}

Vertex3ui Vertex3uiMake(u_int inX, u_int inY, u_int inZ)
{
	Vertex3ui ret;
	ret.x = inX;
	ret.y = inY;
	ret.z = inZ;
	return ret;
}

void Vertex3uiSet(Vertex3ui *vertex, u_int inX, u_int inY, u_int inZ)
{
	vertex->x = inX;
	vertex->y = inY;
	vertex->z = inZ;
}

Vector3f Vector3fMake(CGFloat inX, CGFloat inY, CGFloat inZ)
{
	Vector3f ret;
	ret.x = inX;
	ret.y = inY;
	ret.z = inZ;
	return ret;
}

Vector3ui Vector3uiMake(u_int inX, u_int inY, u_int inZ)
{
	Vector3ui ret;
	ret.x = inX;
	ret.y = inY;
	ret.z = inZ;
	return ret;
}

Color4b Color4bMake(u_char inR, u_char inG, u_char inB, u_char inA)
{
	Color4b ret;
	ret.r = inR;
	ret.g = inG;
	ret.b = inB;
	ret.a = inA;
	return ret;
}

float findAngleBetweenVectors(CGPoint v1,CGPoint v2) {
    float angle = atanf(v2.y/v2.x) - atanf(v1.y/v1.x);
    return RADIANS_TO_DEGREES(angle);
}

void QuadToTrianglesWindCWSet(u_short *vertex, CGFloat ul, CGFloat ur, CGFloat ll, CGFloat lr)
{
	// Break a quad into two triangles, since OpenGL ES does not support quads. Clockwise winding.
	vertex[0] = lr;
	vertex[1] = ll;
	vertex[2] = ul;
	vertex[3] = lr;
	vertex[4] = ul;
	vertex[5] = ur;
}

void QuadToTrianglesWindCCWSet(u_short *vertex, CGFloat ul, CGFloat ur, CGFloat ll, CGFloat lr)
{
	// Break a quad into two triangles, since OpenGL ES does not support quads. Counter-clockwise winding.
	vertex[0] = lr;
	vertex[1] = ul;
	vertex[2] = ll;
	vertex[3] = lr;
	vertex[4] = ur;
	vertex[5] = ul;
}



void vec2Diff( vec2 *_v1, vec2 *_v2, vec2 *_v3 )
{
	_v3->x = _v1->x - _v2->x;
	_v3->y = _v1->y - _v2->y;
}


void vec3Add( vec3 *_v1, vec3 *_v2, vec3 *_v3 )
{
	_v3->x = _v1->x + _v2->x;
	_v3->y = _v1->y + _v2->y;
	_v3->z = _v1->z + _v2->z;
}


void vec3Diff( vec3 *_v1, vec3 *_v2, vec3 *_v3 )
{
	_v3->x = _v1->x - _v2->x;
	_v3->y = _v1->y - _v2->y;
	_v3->z = _v1->z - _v2->z;
}


float magnitude( vec3 *_v1 )
{
	return sqrtf( ( _v1->x * _v1->x ) +
				 ( _v1->y * _v1->y ) +
				 ( _v1->z * _v1->z ) );
}


float distance( vec3 *_v1, vec3 *_v2 )
{
	vec3 v3;
	
	vec3Diff( _v1, _v2, &v3 );
	
	return magnitude( &v3 );
}


float normalize( vec3 *_v1, vec3 *_v2 )
{
	float len = magnitude( _v1 ),
	mag;
	
	if( !len )
	{ return 0.0f; }
	
	mag = 1.0f / len;
	
	_v2->x = _v1->x * mag;
	_v2->y = _v1->y * mag;
	_v2->z = _v1->z * mag;
	
	return len;
}


float dotProduct( vec3 *_v1, vec3 *_v2 )
{
	return ( _v1->x * _v2->x ) +
	( _v1->y * _v2->y ) +
	( _v1->z * _v2->z );
}


float dotProductToDeg( vec3 *_v1, vec3 *_v2 )
{
	float dp = dotProduct( _v1, _v2 );
	
	if( dp > 0.999f )
	{ return 0.0f; }
	
	return RADIANS_TO_DEGREES (acosf( dp ));
}


void crossProduct( vec3 *_v1, vec3 *_v2, vec3 *_v3 )
{
	_v3->x = ( _v1->y * _v2->z ) - ( _v2->y * _v1->z );
	_v3->y = ( _v1->z * _v2->x ) - ( _v2->z * _v1->x );
	_v3->z = ( _v1->x * _v2->y ) - ( _v2->x * _v1->y );
}

char projectToScreen ( float objx,
                      float objy,
                      float objz,
                      float model   [ 16 ],
                      float proj    [ 16 ],
                      int   viewport[ 4  ],
                      float *winx,
                      float *winy,
                      float *winz )
{
	float tin [ 4 ],
	tout[ 4 ];
	
	tin[ 0 ] = objx;
	tin[ 1 ] = objy;
	tin[ 2 ] = objz;
	tin[ 3 ] = 1.0f;
	
#define M( row, col ) model[ col * 4 + row ]
	
	tout[ 0 ] = M( 0, 0 ) * tin[ 0 ] + M( 0, 1 ) * tin[ 1 ] + M( 0, 2 ) * tin[ 2 ] + M( 0, 3 ) * tin[ 3 ];
	tout[ 1 ] = M( 1, 0 ) * tin[ 0 ] + M( 1, 1 ) * tin[ 1 ] + M( 1, 2 ) * tin[ 2 ] + M( 1, 3 ) * tin[ 3 ];
	tout[ 2 ] = M( 2, 0 ) * tin[ 0 ] + M( 2, 1 ) * tin[ 1 ] + M( 2, 2 ) * tin[ 2 ] + M( 2, 3 ) * tin[ 3 ];
	tout[ 3 ] = M( 3, 0 ) * tin[ 0 ] + M( 3, 1 ) * tin[ 1 ] + M( 3, 2 ) * tin[ 2 ] + M( 3, 3 ) * tin[ 3 ];
#undef M
	
	
#define M( row, col ) proj[ col * 4 + row ]
	
	tin[ 0 ] = M( 0, 0 ) * tout[ 0 ] + M( 0, 1 ) * tout[ 1 ] + M( 0, 2 ) * tout[ 2 ] + M( 0, 3 ) * tout[ 3 ];
	tin[ 1 ] = M( 1, 0 ) * tout[ 0 ] + M( 1, 1 ) * tout[ 1 ] + M( 1, 2 ) * tout[ 2 ] + M( 1, 3 ) * tout[ 3 ];
	tin[ 2 ] = M( 2, 0 ) * tout[ 0 ] + M( 2, 1 ) * tout[ 1 ] + M( 2, 2 ) * tout[ 2 ] + M( 2, 3 ) * tout[ 3 ];
	tin[ 3 ] = M( 3, 0 ) * tout[ 0 ] + M( 3, 1 ) * tout[ 1 ] + M( 3, 2 ) * tout[ 2 ] + M( 3, 3 ) * tout[ 3 ];
#undef M
	
	if( !tin[ 3 ] )
	{ return 0; }
	
	tin[ 0 ] /= tin[ 3 ];
	tin[ 1 ] /= tin[ 3 ];
	tin[ 2 ] /= tin[ 3 ];
	
	*winx = viewport[ 0 ] + ( 1.0f + tin[ 0 ] ) * viewport[ 2 ] * 0.5f;
	*winy = viewport[ 1 ] + ( 1.0f + tin[ 1 ] ) * viewport[ 3 ] * 0.5f;
	*winz = ( 1.0f + tin[ 2 ] ) * 0.5f;
	
	return 1;
}

@implementation MathHelper

+ (CGFloat) lerpRangesValue:(CGFloat)value minOrigRange:(CGFloat)minLeft maxOrigRange:(CGFloat)maxLeft 
				minNewRange:(CGFloat)minRight maxNewRange:(CGFloat)maxRight {
	CGFloat leftRangeDelta = maxLeft - minLeft; //screenResolution for example
	CGFloat rightRangeDelta = maxRight - minRight; //local GL view position for example
	CGFloat scaleFactorRange = rightRangeDelta / leftRangeDelta;
	return ( ((value - minLeft)*scaleFactorRange) + minRight );
}

@end
