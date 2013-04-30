//
//  Location.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <MapKit/MKGeometry.h>

@interface Location : NSObject {
    double latitude;
    double longitude;
}

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

- (id) initWithLatitude: (double) theLatitude longitude: (double) theLongitude;
- (id) initWithDictionary: (NSDictionary *) locationDict;
- (id) initWithCoordinate: (CLLocationCoordinate2D) coordinate;

- (NSDictionary *) asDictionary;
- (NSString *) asComma;
- (CLLocationCoordinate2D) asCoordinate;
- (NSString *) description;

+ (NSDictionary *) meanInfo: (NSArray *) locations;
+ (MKCoordinateSpan) span: (NSArray *) locations;


@end
