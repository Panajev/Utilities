//
//  Average.m
//  Utilities
//
//  Created by Goffredo Marocchi on 10/13/10.
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

#import "Average.h"
#import "LogDefines.h"

@interface Average ()
-(BOOL) testAverage;
-(void) resetAverage;

@end


@implementation Average
@synthesize avg_size;

-(id) init {
	if( (self = [super init]) ) {
		currentAverage = 0.0f;
		index = 0;
		avg_size = 4;
	}	
	return self;
}

-(void) resetAverage {
	currentAverage = 0.0f;
	index = 0;
}

-(void) addSample:(float) arg {
	if (index < avg_size) {
		currentAverage += arg;
		index++;
	}
	else {
		currentAverage = arg;
		index = 1;
	}

}
-(float) getAverage {
	return (currentAverage/(float)index);
}

-(BOOL) testAverage {
	[self resetAverage];
	[self addSample:2];
	[self addSample:5];
	[self addSample:8];
	[self addSample:12];
	
	float avg = [self getAverage];
	
	if (avg >= (2+5+8+12)/4.0f) { 
		CMLog (@"Average = %f", avg);
		CMLog (@"Index value = %d, AVG_SIZE = %d", index, avg_size);
		[self resetAverage];
		return YES;
	}
	else {
		CMLog (@"Average should be = %f, but is = %f", ((2+5+8+12)/4.0f), avg);
		[self resetAverage];
		NSAssert(0, @"(!)");
		return NO;
	}
}


@end
