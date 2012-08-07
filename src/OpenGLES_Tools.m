//
//  OpenGLES_Tools.m
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

#import "OpenGLES_Tools.h"
#import "SysTools.h"


@implementation OpenGLES_Tools

+(void) checkGLerrors {
	/*
	 GL_INVALID_ENUM
	 An unacceptable value is specified for an enumerated argument.
	 The offending command is ignored
	 and has no other side effect than to set the error flag.
	 
	 GL_INVALID_VALUE
	 A numeric argument is out of range.
	 The offending command is ignored
	 and has no other side effect than to set the error flag.
	 
	 GL_INVALID_OPERATION
	 The specified operation is not allowed in the current state.
	 The offending command is ignored
	 and has no other side effect than to set the error flag.
	 
	 GL_STACK_OVERFLOW
	 This command would cause a stack overflow.
	 The offending command is ignored
	 and has no other side effect than to set the error flag.
	 
	 GL_STACK_UNDERFLOW
	 This command would cause a stack underflow.
	 The offending command is ignored
	 and has no other side effect than to set the error flag.
	 
	 GL_OUT_OF_MEMORY
	 There is not enough memory left to execute the command.
	 The state of the GL is undefined,
	 except for the state of the error flags,
	 after this error is recorded.
	 
	 If glGetError itself generates an error, it returns 0.
	 */
#if DEBUG==1
	GLenum err = glGetError();
	if ( GL_NO_ERROR == err) {
		CMLog(@"No OpenGL error so far..."); //no error printed out
	}
	else {
		switch (err) {
			case 0:
				CMLog(@"(!) glGetError itself returned an error (!)");
				break;
			case GL_INVALID_ENUM:
				CMLog(@"(!) glGetError returned: GL_INVALID_ENUM (!)");
				assert(0);
				break;
			case GL_INVALID_VALUE:
				CMLog(@"(!) glGetError returned: GL_INVALID_VALUE (!)");
				assert(0);
				break;
			case GL_INVALID_OPERATION:
				CMLog(@"(!) glGetError returned: GL_INVALID_OPERATION (!)");
				assert(0);
				break;
			case GL_STACK_OVERFLOW:
				CMLog(@"(!) glGetError returned: GL_STACK_OVERFLOW (!)");
				assert(0);
				break;
			case GL_STACK_UNDERFLOW:
				CMLog(@"(!) glGetError returned: GL_STACK_UNDERFLOW (!)");
				assert(0);
				break;
			case GL_OUT_OF_MEMORY:
				CMLog(@"(!) glGetError returned: GL_OUT_OF_MEMORY (!)");
				assert(0);
				break;
			default:
				CMLog(@"(!) glGetError returned: ...unknown error... (!)");
				break;
		}
		CMLog(@"Error in frame. glError: 0x%04X", err);
		assert(0);
	}
#endif
}

+(void) printGLSLAttrib:(GLuint)prog {
	char *name;
	GLint active_attribs, max_length;
	
	glGetProgramiv(prog, GL_ACTIVE_ATTRIBUTES, &active_attribs);
	glGetProgramiv(prog, GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, &max_length);
	
	name = malloc(max_length + 1);
	
	CMLog(@"number of active attributes = %d", active_attribs);
	for (unsigned i = 0; i < active_attribs; i++) {
		GLint size;
		GLenum type;
		
		glGetActiveAttrib(prog, i, max_length + 1, NULL,
						  &size, &type, name);
		CMLog(@"%s is at location %d\n", name, glGetAttribLocation(prog, name));
	}
	free(name);
	name = NULL;
	
	active_attribs = 0;
	glGetProgramiv(prog, GL_ACTIVE_UNIFORMS, &active_attribs);
	glGetProgramiv(prog, GL_ACTIVE_UNIFORM_MAX_LENGTH, &max_length);
	
	name = malloc(max_length + 1);
	
	CMLog(@"number of active uniforms = %d", active_attribs);
	
	for (unsigned i = 0; i < active_attribs; i++) {
		GLint size;
		GLenum type;
		
		glGetActiveUniform(prog, i, max_length + 1, NULL,
						  &size, &type, name);
		CMLog(@"%s is at location %d\n", name, glGetUniformLocation(prog, name));
	}
	free(name);
}

+(void) printShaderLog:(GLuint*)shader verboseMode:(BOOL)verbose {
	if(!shader) return;
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        if(verbose) {
            NSLog(@"Shader compile log:\n%s", log);
        }
        else {
            CMLog(@"Shader compile log:\n%s", log); 
        }
        free(log);
    }
}

+(void) queryGLStateBoundBuffer {
	GLint rb_binding, rb_wide, rb_high, rb_format;
	glGetIntegerv(GL_RENDERBUFFER_BINDING, &rb_binding);
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &rb_wide);
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &rb_high);
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_INTERNAL_FORMAT, &rb_format);
	printf("\nCurrent renderbuffer %d is %dx%d, format %04x\n", rb_binding, rb_wide, rb_high, rb_format);
}
+(void) queryGLStateBoundBufferOES {
	GLint rb_binding, rb_wide, rb_high, rb_format;
	glGetIntegerv(GL_RENDERBUFFER_BINDING_OES, &rb_binding);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &rb_wide);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &rb_high);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_INTERNAL_FORMAT_OES, &rb_format);
	printf("\nCurrent renderbuffer %d is %dx%d, format %04x\n", rb_binding, rb_wide, rb_high, rb_format);
}

+(void) project3DPointToScreen:(float*)vec {
	GLint backingWidth;
	GLint backingHeight;
	float mView[16];
	float mProj[16];
	int mViewPort[4];
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	glGetFloatv(GL_PROJECTION_MATRIX, mProj);
	glGetFloatv(GL_MODELVIEW_MATRIX, mView);
	glGetIntegerv(GL_VIEWPORT, mViewPort);
	//projectToScreen(0, 1, 0, mView, mProj, mViewPort, &xyScreen.x, &xyScreen.y, &xyScreen.z);
	//CMLog (@"\nBacking Width/2 = %.2f, Backing Height = %.2f", backingWidth/2.0f, (float)backingHeight);
	//CMLog(@"point_wcs(0,1,0) = point_screen(%.2f,%.2f)", xyScreen.x, xyScreen.y);
}

+ (int) projectToScreenWithWCS_x:(float)objx
									withWCS_y:(float)objy
									withWCS_z:(float)objz
									withMView:(float*)model
									withProjection:(float*)proj
									withViewport:(int*)viewport
									toScreenX:(float*) winx
									toScreenY:(float*) winy
									toScreenZ:(float*) winz {
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
@end
