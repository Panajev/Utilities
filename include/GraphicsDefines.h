//
//  GraphicsDefines.h
//  Utilities
//
//  Created by Goffredo Marocchi on 12/6/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#ifndef GRAPHICSDEFINES_H
#define GRAPHICSDEFINES_H

#import <Foundation/Foundation.h>

typedef struct
{
	float	x;
	float y;
} Vector2f, Vertex2f, vec2;

typedef struct
{
	short	x;
	short	y;
	short	z;
	short	w;
} Vector4s, Vertex4s;

typedef struct
{
	float	x;
	float	y;
	float	z;
	float	w;
} Vector4f, Vertex4f;

typedef struct
{
	float	u;
	float	v;
} Texture2f, tex2f;

typedef struct
{
	u_int x;
	u_int y;
} Vector2ui;
typedef Vector2ui Vertex2ui;

typedef struct
{
	float	x;
	float y;
	float z;
} Vector3f, vec3, Vertex3f;

typedef struct
{
	u_int x;
	u_int y;
	u_int z;
} Vector3ui;
typedef Vector3ui Vertex3ui;

typedef struct
{
	u_char r;
	u_char g;
	u_char b;
	u_char a;
} Color4b;

typedef struct {
	Vector3f position;
	Vector2f texcoord;
} VertexBufferElement;

typedef struct {
	Vector2f position;
	Texture2f texcoord;
} VertexBufferElement2D;

typedef struct {
	Vector4f position;
	Texture2f texcoord;
} VertexBufferElement4D;

// Index to bind the attributes to vertex shaders
typedef enum vShaderAttributes{
    ATTRIB_VERTEX,
    ATTRIB_TEXCOORD,
	ATTRIB_NORMAL,
	ATTRIB_TANGENT,
    NUM_ATTRIBUTES
} vShaderAttributes;

typedef enum vShaderTypes{
    SHADER_STANDARD,
    SHADER_FAST_LIGHT,
	SHADER_FAST_RTT,
    SHADER_HQ,
    SHADER_STANDARD_UNTEXTURED,
    SHADER_IOS3,
    NUM_SHADERTYPES
} vShaderTypes;

#import "CoreGraphicsExt.h"
#import "MathHelper.h"

#define ROT_X(xin, yin, angle)    ((xin * cosf(angle)) - (yin * sinf(angle)))
#define ROT_Y(xin, yin, angle)    ((xin * sinf(angle)) + (yin * cosf(angle)))
#define ROT_Z(xin, zin, angle)    ((xin * sinf(angle)) + (zin * cosf(angle)))

#endif