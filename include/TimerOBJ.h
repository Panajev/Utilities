//
//  TimerOBJ.h
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

#import <Foundation/Foundation.h>
#import <stdio.h>


@interface TimerOBJ : NSObject {
}

-(void) recordTime;
-(void) printDate;
-(void) printTime;
+(NSDate*) dateFromYear:(int)yyyy month:(int)MM day:(int)dd hour:(int)HH minutes:(int)mm seconds:(int)ss;

-(NSString *) dateToString;
-(NSString *) timeToString;

@property unsigned dateFlags;

@property (strong) NSDate *day;
@property (strong) NSCalendar *cal;
@property (strong) NSDateComponents *comps;

@end
