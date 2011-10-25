//
//  LogDefines.h
//  Utilities
//
//  Created by Goffredo Marocchi on 5/29/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#ifndef LOGDEFINES_H
#define LOGDEFINES_H

#if DEBUG==1
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	CMLog(@"%s", __PRETTY_FUNCTION__);
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);
#define DPRINTF(message, ...) printf(message, ## __VA_ARGS__);
#define PRINT_VEC(v) printf("\n(vector) x= %f, y= %f, z = %f\n", (v).x, (v).y, (v).z);
#define PRINT_SVEC(str,v) printf("\n%s x= %f, y= %f, z = %f\n", str, (v).x, (v).y, (v).z);
#define PRINT_VEC2(v) printf("\n(vector) x= %f, y= %f\n", (v).x, (v).y);
#define PRINT_SVEC2(str,v) printf("\n%s x= %f, y= %f\n", str, (v).x, (v).y);
#define PRINT_VEC4(v) printf("\n(vector) x= %f, y= %f, z = %f, w = %f\n", (v).x, (v).y, (v).z, (v).w);
#define PRINT_SVEC4(str,v) printf("\n%s x= %f, y= %f, z = %f, w = %f\n", str, (v).x, (v).y, (v).z, (v).w);
#define PRINT_BULLETVEC(str,v) printf("\n%s x= %f, y= %f, z = %f, w = %f\n", str, (v).x(), (v).y(), (v).z(), (v).w());
#else
#define CMLog(format, ...)
#define MARK
#define START_TIMER
#define END_TIMER(msg)
#define DPRINTF
#define PRINT_VEC(v)
#define PRINT_SVEC(str,v)
#define PRINT_VEC2(v) 
#define PRINT_SVEC2(str,v) 
#define PRINT_VEC4(v) 
#define PRINT_SVEC4(str,v) 
#define PRINT_BULLETVEC(str,v)
#endif

#endif /*LOGDEFINES_H*/