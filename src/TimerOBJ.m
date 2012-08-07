//
//  TimerOBJ.m
//  WapTool
//
//  Created by Goffredo Marocchi on 1/25/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

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
