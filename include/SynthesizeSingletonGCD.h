//
//  SingletonGCD.h
//  Utilities
//
//  Original at: https://gist.github.com/1057420#gistcomment-63896
//  Created by Goffredo Marocchi on 8/6/12.
//  Copyright (c) 2012 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

/*
* @function Singleton GCD Macro, do not use it if you need to call a custom init method
*/
#ifndef SINGLETON_GCD

#define SINGLETON_GCD(classname)                        \
\
+ (classname *)sharedInstance {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}

#define SINGLETON_GCD_HEADERS(classname)                        \
\
+ (classname *)sharedInstance;

#endif
