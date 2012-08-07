//
//  DeviceInfo.m
//  Utilities
//
//  Created by Goffredo Marocchi on 9/21/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import "DeviceInfo.h"

@interface DeviceInfo ()

-(void) updateLogic_and_RenderTimes;

@end

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(DeviceInfo);

@implementation DeviceInfo

SYNTHESIZE_SINGLETON_FOR_CLASS(DeviceInfo);

@synthesize refreshTime, frameInterval, renderTimeMS, renderTimeSeconds, logicTimeMS, logicTimeSeconds;

-(void) updateLogic_and_RenderTimes {	
	logicTimeSeconds = frameInterval * (refreshTime / 2.0f);
	logicTimeMS = logicTimeSeconds * 1000.0f;
	renderTimeSeconds = frameInterval * refreshTime;
	renderTimeMS = renderTimeSeconds * 1000.0f;
}

-(void) setRefreshTime:(float)time {
	refreshTime = time;
	[self updateLogic_and_RenderTimes];
}

-(void) setFrameInterval:(unsigned int)f {
	frameInterval = f;
	[self updateLogic_and_RenderTimes];
}

@end
