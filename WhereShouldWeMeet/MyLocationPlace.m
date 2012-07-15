//
//  MyLocationPlace.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLocationPlace.h"
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocation.h>
#import "Coordinate.h"

@implementation MyLocationPlace

- (id) init {
    if (self = [super init]){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (NSString *) placeType {
    return @"Me";
}

- (NSString *) description {
    return @"My Location";
}
                                
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.coordinate = [[Coordinate alloc] initWithLocation:newLocation];
    self.isLoaded = YES;
    [manager stopUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Failed with error %@", error);
}

@end
