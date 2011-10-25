//
//  Average.h
//  Utilities
//
//  Created by Goffredo Marocchi on 10/13/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Average : NSObject {
	float currentAverage;
	int index;
}
@property (assign) int avg_size;
-(void) addSample:(float) arg;
-(float) getAverage;
@end
