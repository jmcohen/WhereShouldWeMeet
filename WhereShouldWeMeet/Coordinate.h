//
//  Location.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface Coordinate : NSObject {
    NSString *latitude;
    NSString *longitude;
}

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

- (id) initWithLatitude: (NSString *) theLatitude longitude: (NSString *) theLongitude;
- (id) initWithDictionary: (NSDictionary *) coordinateDict;
- (id) initWithLocation: (CLLocation *) clLocation;
- (id) initWithJson: (NSString *) json;

- (NSDictionary *) asDictionary;

+ (NSDictionary *) meanInfo: (NSArray *) coordinates;

@end
