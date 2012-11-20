//
//  LogDefines.h
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

#ifndef LOGDEFINES_H
#define LOGDEFINES_H

#if DEBUG==1

#define CMLog(format, ...) do{NSLog(@"(DEBUG)\n\t%s (at %@:%d):\n\tLOG: %@\n", __PRETTY_FUNCTION__, \
[[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__, \
[NSString stringWithFormat:format, ## __VA_ARGS__]);} while(0)

#define DNSLog(format, ...) do{NSLog(@"%@\n",[NSString stringWithFormat:format, ## __VA_ARGS__]);} while(0)

#define MARK	do{CMLog(@"MARKER");} while(0)

#define QMARK	do{NSLog(@"MARKER: %s, (at %@:%d)", __PRETTY_FUNCTION__, [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__);} while(0)

#define XASSERT(test, msg, ...) do {if (!(test)) error(__LINE__, __FILE__, \
"Assertion failed: %s\n\n" msg, #test,  __VA_ARGS__);} while (0)

#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);
#ifndef DPRINTF
#define DPRINTF(message, ...) printf(message, ## __VA_ARGS__);
#endif
#define PRINT_VEC(v) printf("\n(vector) x= %f, y= %f, z = %f\n", (v).x, (v).y, (v).z);
#define PRINT_SVEC(str,v) printf("\n%s x= %f, y= %f, z = %f\n", str, (v).x, (v).y, (v).z);
#define PRINT_VEC2(v) printf("\n(vector) x= %f, y= %f\n", (v).x, (v).y);
#define PRINT_SVEC2(str,v) printf("\n%s x= %f, y= %f\n", str, (v).x, (v).y);
#define PRINT_VEC4(v) printf("\n(vector) x= %f, y= %f, z = %f, w = %f\n", (v).x, (v).y, (v).z, (v).w);
#define PRINT_SVEC4(str,v) printf("\n%s x= %f, y= %f, z = %f, w = %f\n", str, (v).x, (v).y, (v).z, (v).w);
#define PRINT_BULLETVEC(str,v) printf("\n%s x= %f, y= %f, z = %f, w = %f\n", str, (v).x(), (v).y(), (v).z(), (v).w());
#else
#define CMLog(format, ...)
#define DNSLog(format, ...)
#define MARK
#define QMARK
#define XASSERT(test, msg, ...)
#define START_TIMER
#define END_TIMER(msg)
#ifndef DPRINTF
#define DPRINTF
#endif
#define PRINT_VEC(v)
#define PRINT_SVEC(str,v)
#define PRINT_VEC2(v) 
#define PRINT_SVEC2(str,v) 
#define PRINT_VEC4(v) 
#define PRINT_SVEC4(str,v) 
#define PRINT_BULLETVEC(str,v)
#endif

#endif /*LOGDEFINES_H*/
