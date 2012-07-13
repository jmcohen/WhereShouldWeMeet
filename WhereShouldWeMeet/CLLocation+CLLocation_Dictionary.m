//
//  CLLocation+CLLocation_Dictionary.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CLLocation+CLLocation_Dictionary.h"

@implementation CLLocation (CLLocation_Dictionary)

- (NSDictionary *) toCoordinateDictionary {
    NSNumber *latitude = [NSNumber numberWithFloat:self.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:self.coordinate.longitude];
    return [NSDictionary dictionaryWithObjectsAndKeys: latitude, @"latitude", longitude, @"longitude", nil];
}

@end
