//
//  TimerOBJ.m
//  WapTool
//
//  Created by Goffredo Marocchi on 1/25/10.
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

#import "TimerOBJ.h"
#import "SysTools.h"

@implementation TimerOBJ
@synthesize day, cal, comps, dateFlags;

-(NSCalendar*) cal{
	CMLog (@"cal getter called");
	return cal;
}

-(void) setCal:(NSCalendar *)c {
	CMLog (@"cal setter called");
	cal = c;
}

-(id) init {
	if ((self = [super init])) {
		//super was correctly initialized, it did not return nil
		//Cocoa guarantees that, besides isa variables, all variables and memory is initialized to 0,
		//so we can avoid being redundant and say hh = 0; mm = 0; etc... if 0 is the default value we want.
		day = nil;
		cal = nil;
		comps = nil;
		dateFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |
		NSSecondCalendarUnit | NSWeekdayCalendarUnit;
	}
	return self;
}


-(void) recordTime {	
	self.day = [NSDate date];
	self.cal = [NSCalendar currentCalendar];
	self.comps = [cal components:dateFlags fromDate:self.day];
	
	return;
}

-(NSString *) dateToString {
	NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString* str = [outputFormatter stringFromDate:[self day]];
	
	return str;
}

-(NSString *) timeToString {
	NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"HH:mm:ss"];
	NSString* str = [outputFormatter stringFromDate:[self day]];
	
	return str;
}

-(void) printDate {
	NSLog (@"%@", [self dateToString]);
	return;
}

-(void) printTime {
	NSLog (@"%@", [self timeToString]);
	return;
}

+(NSDate*) dateFromYear:(int)yyyy month:(int)MM day:(int)dd hour:(int)HH minutes:(int)mm seconds:(int)ss {
	NSDateComponents *c = [[NSDateComponents alloc] init];

	[c setYear:yyyy];
	[c setMonth:MM];
	[c setDay:dd];
	
	[c setHour:HH];
	[c setMinute:mm];
	[c setSecond:ss];

	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate* date = [gregorian dateFromComponents:c];
	
	
	return date;
}

@end
