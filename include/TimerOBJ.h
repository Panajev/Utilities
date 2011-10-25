//
//  TimerOBJ.h
//  WapTool
//
//  Created by Goffredo Marocchi on 1/25/10.
//  Copyright 2010 IGGS. All rights reserved.
//

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

@property (retain) NSDate *day;
@property (retain) NSCalendar *cal;
@property (retain) NSDateComponents *comps;

@end
