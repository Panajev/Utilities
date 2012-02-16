//
//  CoreGraphicsExt.m
//  Utilities
//
//  Created by Goffredo Marocchi on 11/12/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoreGraphicsExt.h"
#import "LogDefines.h"
#import "GeneralDefines.h"


BOOL CGCircleContainsPoint (CGFloat circleRadius, CGPoint origin, CGPoint p) {
    BOOL isInCircle = false;
	if(CGDistanceBetweenPoints(p, origin) <= circleRadius){
		isInCircle = true;
	}
	return isInCircle;
}
CGFloat CGAngleDifference(CGFloat angleA, CGFloat angleB) {
    float diff = fabs(angleA-angleB);
	if(fabs((angleA+360)-angleB) < diff){
		diff = fabs((angleA+360)-angleB);
	}
	if(fabs((angleA-360)-angleB) < diff){
		diff = fabs((angleA-360)-angleB);
	}
	if(fabs(angleA-(angleB+360)) < diff){
		diff = fabs(angleA-(angleB+360));
	}
	if(fabs(angleA-(angleB-360)) < diff){
		diff = fabs(angleA-(angleB-360));
	}
	return diff;
}

CGFloat CGVectorToRadians(CGPoint vector){
	if(vector.y == 0){ vector.y = 0.000001f; }
	float baseRadians = atanf(vector.x/vector.y);
	if(vector.y < 0){ baseRadians += M_PI; }	//Adjust for -Y
	return baseRadians;
}
CGPoint CGRadiansToVector(CGFloat radians){
	return CGPointMake(sinf(radians-M_PI/2), cosf(radians-M_PI/2));
};

/* Math code all pulled (and modified) from http://forums.macrumors.com/showthread.php?t=508042 */

CGPoint CGVectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
	CMLog(@"Point One: %f, %f", firstPoint.x, firstPoint.y);
	CMLog(@"Point Two: %f, %f", secondPoint.x, secondPoint.y);
	
	CGFloat xDifference = firstPoint.x - secondPoint.x;
	CGFloat yDifference = firstPoint.y - secondPoint.y;
	
	CGPoint result = CGPointMake(xDifference, yDifference);
	
	return result;
}

CGFloat CGDistanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
	CGFloat distance;
	
	//Square difference in x
	CGFloat xDifferenceSquared = powf(firstPoint.x - secondPoint.x, 2);
	CMLog(@"xDifferenceSquared: %f", xDifferenceSquared);
	
	// Square difference in y
	CGFloat yDifferenceSquared = powf(firstPoint.y - secondPoint.y, 2);
	CMLog(@"yDifferenceSquared: %f", yDifferenceSquared);
	
	// Add and take Square root
	distance = sqrtf(xDifferenceSquared + yDifferenceSquared);
	CMLog(@"Distance: %f", distance);
	return distance;
	
}

CGFloat CGAngleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint){
	CGPoint previousDifference = CGVectorBetweenPoints(firstPoint, secondPoint);
	CGFloat xDifferencePrevious = previousDifference.x;
	
	CGFloat previousDistance;
	CGFloat previousRotation;
	
	if (xDifferencePrevious < 0) {
		xDifferencePrevious *= -1.0f;
		previousDistance = CGDistanceBetweenPoints(secondPoint, firstPoint);
		previousRotation = acosf(xDifferencePrevious / previousDistance);
	}
	else {
		previousDistance = CGDistanceBetweenPoints(firstPoint, secondPoint);
		previousRotation = acosf(xDifferencePrevious / previousDistance);
	}
	
	CMLog(@"\n ------------------- \n temp angle = %.2f \n -------------------", 
		  RADIANS_TO_DEGREES((previousDistance < 0.0001)?0.0f:previousRotation));
	
	return (previousDistance < 0.0001f)?0.0f:previousRotation;
}

CGFloat CGAngleBetweenCGLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
	
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
	
    return atanA - atanB;
}

CGFloat CGAngleWithXaxis(CGPoint line1Start, CGPoint line1End) {
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = (line1End.y - line1Start.y)*(-1.0f);
    CGFloat c = ABS((CGFloat)a) + 1.0f;
    CGFloat d = 0.0f;
	
	a = (a  < 0.0f || a < 0.0001f)?1.0f:a;
	
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
	
	CMLog(@"\n ------------------- \n temp angle = %.2f \n -------------------", 
		  RADIANS_TO_DEGREES(atanB - atanA));
	
    return (atanB - atanA);
}
