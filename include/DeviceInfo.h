//
//  DeviceInfo.h
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

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface DeviceInfo : NSObject {

}

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(DeviceInfo);

@property (nonatomic, assign) float refreshTime;
@property (nonatomic, assign) unsigned int frameInterval;
@property (nonatomic, readonly) float renderTimeMS;
@property (nonatomic, readonly) float renderTimeSeconds;
@property (nonatomic, readonly) float logicTimeMS;
@property (nonatomic, readonly) float logicTimeSeconds;


@end
