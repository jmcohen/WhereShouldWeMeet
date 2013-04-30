//
//  Venue.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import "Location.h"
#import <MapKit/MKAnnotation.h>

@interface Venue : NSObject <MKAnnotation> {
    NSString *name;
    NSString *address;
    NSNumber *rating;
    Location *location;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) Location *location;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
