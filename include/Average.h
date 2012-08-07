//
//  Average.h
//  Utilities
//
//  Created by Goffredo Marocchi on 10/13/10.
//  Copyright 2010 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import <Foundation/Foundation.h>

@interface Average : NSObject {
	float currentAverage;
	int index;
}
@property (assign) int avg_size;
-(void) addSample:(float) arg;
-(float) getAverage;
@end
