//
//  OpenGLES_Tools.h
//  Utilities
//
//  Created by Goffredo Marocchi on 11/12/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import <Foundation/Foundation.h>
#import "GraphicsDefines.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#define GL_ROTATE_TO_LANDSCAPE() do{glRotatef( -90.0f, 0.0f, 0.0f, 1.0f );}while
#define VBO_OFFSET(i) ((char *)NULL + (i))

//vertex and texture data for now
#define NUMBER_OF_COMPONENTS_PER_VERTEX (3)
#define NUMBER_OF_COMPONENTS_PER_TEXTURECOORD (2)

#define V_SIZE (NUMBER_OF_COMPONENTS_PER_VERTEX * sizeof(GLfloat))
#define GL_ENABLE_VERTEX_ATTRIBUTES() do{glEnableVertexAttribArray(ATTRIB_VERTEX);\
glEnableVertexAttribArray(ATTRIB_TEXCOORD);}while(0)

#define GL_DISABLE_VERTEX_ATTRIBUTES() do{glDisableVertexAttribArray(ATTRIB_VERTEX);\
glDisableVertexAttribArray(ATTRIB_TEXCOORD);}while(0)


@interface OpenGLES_Tools : NSObject {
	
}

+(void) checkGLerrors;
+(void) printGLSLAttrib:(GLuint)prog;
+(void) printShaderLog:(GLuint*)shaderObj verboseMode:(BOOL)verbose;
+(void) queryGLStateBoundBuffer;
+(void) queryGLStateBoundBufferOES;
+(void) project3DPointToScreen:(float*)vec;
+(int) projectToScreenWithWCS_x:(float)objx withWCS_y:(float)objy withWCS_z:(float)objz 
					   withMView:(float*)model withProjection:(float*)proj withViewport:(int*)viewport
					   toScreenX:(float*) winx toScreenY:(float*) winy toScreenZ:(float*) winz;
@end
