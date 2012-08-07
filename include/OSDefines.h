//
//  OSDefines.h
//  Utilities
//
//  Created by Goffredo Marocchi on 5/29/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

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
