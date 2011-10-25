//
//  DeviceInfo.h
//  Utilities
//
//  Created by Goffredo Marocchi on 9/21/10.
//  Copyright 2010 IGGS. All rights reserved.
//

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
