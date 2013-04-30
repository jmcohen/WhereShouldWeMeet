//
//  Location.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize latitude, longitude;

- (id) initWithLatitude: (double) theLatitude longitude: (double) theLongitude {
    if (self = [super init]){
        latitude = theLatitude;
        longitude = theLongitude;
    }
    return self;
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate{
    return [self initWithLatitude: coordinate.latitude
                        longitude: coordinate.longitude ];
}

- (id) initWithDictionary:(NSDictionary *)locationDict{
    return [self initWithLatitude:((NSString *)[locationDict objectForKey:@"latitude"]).doubleValue
                        longitude:((NSString *)[locationDict objectForKey:@"longitude"]).doubleValue];
}

- (NSDictionary *) asDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble: latitude], @"latitude", [NSNumber numberWithDouble: longitude], @"longitude", nil];
}

- (NSString *) asComma {
    return [NSString stringWithFormat:@"%f,%f", latitude, longitude];
}

- (CLLocationCoordinate2D) asCoordinate {
    return CLLocationCoordinate2DMake(latitude, longitude);
}

- (NSString *) description{
    BOOL north = latitude > 0;
    BOOL east = longitude > 0;
    return [NSString stringWithFormat:@"%.3f° %@, %.3f° %@", north ? latitude : -latitude , north ? @"N" : @"S" , east ? longitude : -longitude , east ? @"E" : @"W"];
}

double toRadians (double degrees){
    double radians = degrees * M_PI / 180;
    return radians;
}

double distance (double lat1Degrees, double lon1Degrees, double lat2Degrees, double lon2Degrees) { // Finds the distance between two geographic cooordinates using the spherical law of cosines
    double r = 6378000; // Meters.
    double   lat1 = toRadians(lat1Degrees),
            lat2 = toRadians(lat2Degrees),
            lon1 = toRadians(lon1Degrees),  
            lon2 = toRadians(lon2Degrees);
    double dist = acosf(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon2 - lon1)) * r;

    return dist;
}

+ (NSDictionary *) meanInfo: (NSArray *) locations {
    int numLocations = locations.count;
    double latitudes[numLocations], longitudes[numLocations];
    double totalLatitude = 0, totalLongitude = 0;
    for (int i = 0; i < numLocations; i++){
        Location *location = [locations objectAtIndex:i];
        latitudes[i] = location.latitude;
        longitudes[i] = location.longitude;
        totalLatitude += latitudes[i];
        totalLongitude += longitudes[i];
    }
    double averageLatitude = totalLatitude / numLocations;
    double averageLongitude = totalLongitude / numLocations;
    double totalDistance = 0; // distance from the center
    for (int i = 0; i < numLocations; i++)
        totalDistance += distance(latitudes[i], longitudes[i], averageLatitude, averageLongitude);
    double averageDistance = totalDistance / numLocations;
    Location *meanPosition = [[Location alloc] initWithLatitude:averageLatitude longitude:averageLongitude];
    return [NSDictionary dictionaryWithObjectsAndKeys:meanPosition, @"position", [NSNumber numberWithDouble:averageDistance], @"distance", nil];
}

+ (MKCoordinateSpan) span:(NSArray *)locations {
    double minLat = 180, maxLat = -180;
    double minLon = 180, maxLon = -180;
    
    for (Location *location in locations){
        double lat = location.latitude;
        double lon = location.longitude;
        if (lat < minLat) minLat = lat;
        if (lat > maxLat) maxLat = lat;
        if (lon < minLon) minLon = lon;
        if (lon > maxLon) maxLon = lon;
    }
    double latSpan = fabs(maxLat - minLat);
    double lonSpan = fabs(maxLon - minLon);
    return MKCoordinateSpanMake(latSpan, lonSpan);
}

@end
