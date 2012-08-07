//
//  GeneralDefines.h
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

#ifndef GENERALDEFINES_H
#define GENERALDEFINES_H

#define PNG @"png"
#define MAX_FPS (120.0f)
#define MIN_FPS (10.0f)
#define UPDATE_TIME (1.0f / MAX_FPS)
#define MAX_CPF (MAX_FPS / MIN_FPS)
#define DT (1.0f/30.f)

#define aEPS (0.0001f)

#define LARGE_OBJ (128)
#define MID_OBJ (64)
#define SMALL_OBJ (32)
#define TINY_OBJ (16)
#define UNIT_OBJ (8)

//x must be a single digit between 0 and 9
#define TO_CHAR(x) ((x)+'0')
#define TO_INT(x) ((x)-'0')

#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define DEGREES_TO_RADIANS(__ANGLE__) (((__ANGLE__) / 180.0f) * M_PI)
#define RAD (180.0f / M_PI)
#define RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * RAD)
#define DEG_TO_RAD_FACTOR				0.017453f
#define RAD_TO_DEG_FACTOR				57.29577f

#define IN_RANGE(x,lb,rb) ((x>lb) && (x<rb))
#define CLAMP_VAL(x,min,max) ((x > min && x < max)?x:((x>=max)?max:min))
#define KINDOF_EQ_FP(x) (IN_RANGE(x,(x-0.0001f),(x+0.0001f)))

#endif
