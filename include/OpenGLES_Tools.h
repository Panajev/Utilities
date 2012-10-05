//
//  OpenGLES_Tools.h
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

#ifdef __CC_PLATFORM_IOS

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

#endif