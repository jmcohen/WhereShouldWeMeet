//
//  WhereShouldWeMeet.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WhereShouldWeMeet.h"
#import "AppDelegate.h"
#import "CLLocationManager+blocks.h"
#import "FriendLocationPlace.h"
#import "Location.h"
#import "FriendsLocationEngine.h"
#import "LocalSearchEngine.h"
#import "UIAlertView+Blocks.h"

@implementation WhereShouldWeMeet

static WhereShouldWeMeet *_manager = NULL;

@synthesize places, locations, categories, selectedCategories, userFriends, venues, appDelegate;

- (id) init {
    if (self = [super init]){
        places = [NSMutableArray array];
        categories = [LocalSearchEngine categories];
        selectedCategories = [NSMutableArray array];
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
        [self.appDelegate.friendsLocationEngine reportLocation:([[Location alloc] initWithCoordinate:newLocation.coordinate]) toFriend:facebookId];
        [manager stopUpdatingLocation];
    } errorBlock:^(NSError *error) {
        NSLog(@"Error updating location: %@", error);
    }];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}

- (void) user:(NSString *)facebookId didReportLocation:(Location *)location{
    for (id place in self.places)
        if ([place isKindOfClass:[FriendLocationPlace class]]){
            if ([[place friend].id isEqualToString:facebookId]) {
                [place setLocation: location];
            }
        }
}

float searchRadius(float meanDistance){
    float LOWER_LIMIT = 5000;
    float UPPER_LIMIT = 50000;
    float radius = meanDistance * .2;
    if (radius > UPPER_LIMIT)
        radius = UPPER_LIMIT;
    else if (radius < LOWER_LIMIT)
        radius = LOWER_LIMIT;
    return radius;
}

    
- (void) loadVenues {
    self.locations = [NSMutableArray array];
    for (Place *place in self.places)
        if (place.location){
            [locations addObject:place.location];
        }
    
    NSDictionary *meanInfo = [Location meanInfo: locations];
    Location *meanPosition = [meanInfo objectForKey:@"position"];
    NSNumber *meanDistance = [meanInfo objectForKey:@"distance"];
    NSNumber *radius = [NSNumber numberWithFloat:searchRadius(meanDistance.floatValue)];
    [self.appDelegate.localSearchEngine getVenuesForLocation:meanPosition radius: radius selectedCategories:self.selectedCategories
    onSuccess:^(NSArray *theVenues) {
        self.venues = theVenues;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VenuesLoaded" object:self]; 
    }
     onEmpty:^{
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Venues" message:@"We couldn't find any venues of the selected types near the geographic center." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alertView show];
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
