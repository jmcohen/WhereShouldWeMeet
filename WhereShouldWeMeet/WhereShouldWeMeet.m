//
//  WhereShouldWeMeet.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WhereShouldWeMeet.h"
#import "Facebook.h"
#import "AppDelegate.h"
#import "CLLocationManager+blocks.h"
#import "FriendLocationPlace.h"
#import "Coordinate.h"
#import "FriendsLocationEngine.h"
#import "CityGridEngine.h"

@implementation WhereShouldWeMeet

static WhereShouldWeMeet *_manager = NULL;

@synthesize places, categories, category, userFriends, venues, appDelegate;

- (id) init {
    if (self = [super init]){
        places = [NSMutableArray array];
        categories = [NSMutableArray arrayWithObjects: @"Cafe", @"Restaurant", @"Pizzeria", @"Bar", @"Bookstore", @"Clothing store", @"Movie theater", @"Salon", @"Cemetary", nil];
        category = [categories objectAtIndex:0];
        appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void) loadUserFriends {
    [appDelegate.friendsLocationEngine getUserFriendsOnCompletion:^(NSArray *theUserFriends) {
        self.userFriends = theUserFriends;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserFriendsLoaded" object:nil];
    }];
}

- (void) reportLocationToFriend:(NSString *)facebookId{
    locationManager = [[CLLocationManager alloc] initWithUpdateBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation, BOOL *stop) {
        [self.appDelegate.friendsLocationEngine reportCoordinate:[[Coordinate alloc] initWithLocation:newLocation] toFriend:facebookId];
        [manager stopUpdatingLocation];
    } errorBlock:^(NSError *error) {
        NSLog(@"Error updating location: %@", error);
    }];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}

- (void) user:(NSString *)facebookId didReportLocation:(Coordinate *)location{
    for (id place in self.places)
        if ([[place placeType] isEqualToString:@"Friend"]){
            if ([[place friendId] isEqualToString:facebookId]) {
                [place setCoordinate: location];
                [place setIsLoaded:YES];
            }
        }
}

float searchRadius(float meanDistance){
    float LOWER_LIMIT = .5;
    float UPPER_LIMIT = 20;
    float radius = meanDistance;
    if (radius > UPPER_LIMIT)
        radius = UPPER_LIMIT;
    else 
        radius = LOWER_LIMIT;
    return radius;
}

    
- (void) loadVenues {
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for (Place *place in self.places)
        if ([place isLoaded]){
            [coordinates addObject:place.coordinate];
        }
    
    
    NSDictionary *meanInfo = [Coordinate meanInfo: coordinates];
    Coordinate *meanPosition = [meanInfo objectForKey:@"position"];
    NSNumber *meanDistance = [meanInfo objectForKey:@"distance"];
    NSNumber *radius = [NSNumber numberWithFloat:searchRadius(meanDistance.floatValue)];
    [self.appDelegate.cityGridEngine getVenuesForCoordinate:meanPosition radius: radius category:self.category onSuccess:^(NSArray *theVenues) {
        self.venues = theVenues;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VenuesLoaded" object:self]; 
    }];
}

+ (WhereShouldWeMeet *) manager{
    @synchronized(self){
        if (_manager == NULL)
            _manager = [[WhereShouldWeMeet alloc] init];
    }
    return _manager;
}


@end
