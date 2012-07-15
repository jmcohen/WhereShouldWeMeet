//
//  Location.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

@synthesize latitude, longitude;

- (id) initWithLatitude:(NSString *)theLatitude longitude:(NSString *)theLongitude{
    if (self = [super init]){
        latitude = theLatitude;
        longitude = theLongitude;
    }
    return self;
}

- (id) initWithLocation:(CLLocation *)clLocation{
    CLLocationCoordinate2D coordinate = clLocation.coordinate;
    return [self initWithLatitude:[NSString stringWithFormat: @"%f", coordinate.latitude]
                 longitude:[NSString stringWithFormat: @"%f", coordinate.longitude]];
}

- (id) initWithDictionary:(NSDictionary *)coordinateDict{
    return [self initWithLatitude:[coordinateDict objectForKey:@"latitude"]
                        longitude:[coordinateDict objectForKey:@"longitude"]];
}

- (id) initWithJson:(NSString *)json {
    return [self initWithDictionary: [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]];
}

- (NSDictionary *) asDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.latitude, @"latitude", self.longitude, @"longitude", nil];
}

float toRadians (float degrees){
    float radians = degrees * M_PI / 180;
    return radians;
}

float distance (float lat1Degrees, float lon1Degrees, float lat2Degrees, float lon2Degrees) { // Finds the distance between two geographic cooordinates using the spherical law of cosines
    float r = 6371;
    float   lat1 = toRadians(lat1Degrees),
            lat2 = toRadians(lat2Degrees),
            lon1 = toRadians(lon1Degrees),  
            lon2 = toRadians(lon2Degrees);
    float dist = acosf(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon2 - lon1)) * r;

    return dist;
}

+ (NSDictionary *) meanInfo: (NSArray *) coordinates {
    int numCoords = coordinates.count;
    float latitudes[numCoords], longitudes[numCoords];
    float totalLatitude = 0, totalLongitude = 0;
    for (int i = 0; i < numCoords; i++){
        Coordinate *coordinate = [coordinates objectAtIndex:i];
        latitudes[i] = [coordinate.latitude floatValue];
        longitudes[i] = [coordinate.longitude floatValue];
        totalLatitude += latitudes[i];
        totalLongitude += longitudes[i];
    }
    float averageLatitude = totalLatitude / numCoords;
    float averageLongitude = totalLongitude / numCoords;
    float totalDistance = 0; // distance from the center
    for (int i = 0; i < numCoords; i++)
        totalDistance += distance(latitudes[i], longitudes[i], averageLatitude, averageLongitude);
    float averageDistance = totalDistance / numCoords;
    Coordinate *meanPosition = [[Coordinate alloc] initWithLatitude:[NSString stringWithFormat:@"%f", averageLatitude] longitude:[NSString stringWithFormat:@"%f", averageLongitude]];
    return [NSDictionary dictionaryWithObjectsAndKeys:meanPosition, @"position", [NSNumber numberWithFloat:averageDistance], @"distance", nil];
}

@end
