//
//  MyLocationPlace.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Place.h"
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface MyLocationPlace : Place {
    CLLocationManager *locationManager;
}

- (id) init;

@end
