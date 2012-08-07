//
//  OSDefines.h
//  Utilities
//
//  Created by Goffredo Marocchi on 5/29/10.
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

#ifndef OSDEFINES_H
#define OSDEFINES_H

#ifdef IPHONE_SDK_PROJECT
////////////////////////////
//OS defaults///////////////
////////////////////////////
/**
 *Returns OS string: e.g. iPhone OS
 */
#define OS_NAME [[UIDevice currentDevice] systemName]

/**
 *Returns OS version number : e.g. 4.0, 3.1.3
 */
#define OS_VERSION [[UIDevice currentDevice] systemVersion]

#define DEVICE_ORIENTATION ([[UIDevice currentDevice] orientation])
#define IS_DEVICE_LANDSCAPE ( UIDeviceOrientationIsLandscape(DEVICE_ORIENTATION) )
#define IS_DEVICE_PORTRAIT ( UIDeviceOrientationIsPortrait(DEVICE_ORIENTATION) )
#define IS_DEVICE_RIGHT ((DEVICE_ORIENTATION == UIDeviceOrientationLandscapeRight) && IS_DEVICE_LANDSCAPE)
#define IS_DEVICE_UP ((DEVICE_ORIENTATION == UIDeviceOrientationPortrait) && IS_DEVICE_PORTRAIT)
#define IS_DEVICE_FACEUP (UIDeviceOrientationFaceUp == DEVICE_ORIENTATION)
#define IS_DEVICE_FACEDOWN (UIDeviceOrientationFaceDown == DEVICE_ORIENTATION)

#else

/**
 *Returns OS string: e.g. iPhone OS
 */
#define OS_NAME OSX

/**
 *Returns OS version number : e.g. 4.0, 3.1.3
 */
#define OS_VERSION @"10.6.3"

/**
 Checks multi-tasking support, returns a BOOL
 */
#define MULTI_TASKING_OS YES

#endif
////////////////////////////
//Memory Allocation/////////
////////////////////////////
/**
 *convenience macros used to easily place and drain the autorelease pool
 *do not nest them as the pool's var name is hardcoded!
 */
#define LOCAL_AR_POOL_ALLOC() NSAutoreleasePool *local_pool=[[NSAutoreleasePool alloc]init]
#define LOCAL_AR_POOL_DRAIN() [local_pool drain]

#define INIT_OBJ_ARR_NULL(arr, len) do{for(int i=0; i<len; i++) {arr[i] = NULL;}}while(0)
#define SAFE_FREE(ptr) do{if(ptr!=NULL){free(ptr); ptr=NULL;}}while(0)
#define SAFE_DELETE(ptr) do{if(ptr!=NULL){delete ptr; ptr=NULL;}}while(0)
#define SAFE_RELEASE(obj) do{[obj release]; obj=nil;}while(0)
#define SAFE_GLDELETE_BUF_OBJ(count,bufferObject) do{if(bufferObject){glDeleteBuffers(1, &bufferObject);}}while(0)
#define SAFE_GLDELETE_FBO(count,bufferObject) do{if(bufferObject){glDeleteFramebuffers(1, &bufferObject);}}while(0)
#define SAFE_GLDELETE_RBO(count,bufferObject) do{if(bufferObject){glDeleteRenderbuffers(1, &bufferObject);}}while(0)
#define SAFE_GLDELETE_TEX(count,texId) do{if(texId){glDeleteTextures(count, &texId);}}while(0)

#endif /* OSDEFINES_H */
