//
//  Average.m
//  Utilities
//
//  Created by Goffredo Marocchi on 10/13/10.
//  Copyright 2010 IGGS. All rights reserved.
//

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

-(void) dealloc {
	[super dealloc];
}

@end
