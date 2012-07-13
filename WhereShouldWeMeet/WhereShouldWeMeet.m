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
#import "CLLocation+CLLocation_Dictionary.h"
#import "FriendLocationPlace.h"

@implementation WhereShouldWeMeet

static WhereShouldWeMeet *_manager = NULL;

@synthesize places, categories, category, facebook, deviceToken, userFriends, venues;

- (id) init {
    if (self = [super init]){
        places = [NSMutableArray array];
        categories = [NSMutableArray arrayWithObjects: @"Cafe", @"Restaurant", @"Pizzeria", @"Bar", @"Bookstore", @"Clothing store", @"Movie theater", @"Salon", @"Cemetary", nil];
        category = [categories objectAtIndex:0];
        
        facebook = [[Facebook alloc] initWithAppId:@"316475088442311" andDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] 
            && [defaults objectForKey:@"FBExpirationDateKey"]) {
            facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        
        if (![facebook isSessionValid])
            [facebook authorize:nil];
        
    }
    return self;
}

- (void) fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:facebook.accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:facebook.expirationDate forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void) registerUser {
    NSString *url = [NSString stringWithFormat:@"%@/registerUser?accessToken=%@&deviceToken=%@", [WhereShouldWeMeet host], self.facebook.accessToken, self.deviceToken];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                                            }];
}

- (void) loadUserFriends {
    NSString *url = [NSString stringWithFormat:@"%@/getUserFriends?accessToken=%@", [WhereShouldWeMeet host], self.facebook.accessToken];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               self.userFriends = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"UserFriendsLoaded" object:self];
                               }];
}

    
- (void) loadVenues {
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for (Place *place in self.places)
        if ([place isLoaded]){
            [coordinates addObject:place.coordinate];
        }
    NSData *coordinatesJsonData = [NSJSONSerialization dataWithJSONObject:coordinates options:-1 error:nil];
    NSString *coordinatesJson = [[NSString alloc] initWithData:coordinatesJsonData encoding:NSUTF8StringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"%@/getVenues?coordinates=%@&category=%@", [WhereShouldWeMeet host], coordinatesJson, category];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               self.venues = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"VenuesLoaded" object:self];                           
                           }];    
}

- (void) sendCoordinate: (NSDictionary *) coordinate toId: (NSString *) facebookId {
    NSData *coordinateJsonData = [NSJSONSerialization dataWithJSONObject:coordinate options:-1 error:nil];
    NSString *coordinateJson = [[NSString alloc] initWithData:coordinateJsonData encoding:NSUTF8StringEncoding];
    coordinateJson = [coordinateJson stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@/reportLocation?accessToken=%@&id=%@&location=%@", [WhereShouldWeMeet host], self.facebook.accessToken, facebookId, coordinateJson]; 
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                           }]; 
}


- (void) reportLocationToId:(NSString *)facebookId{
    locationManager = [[CLLocationManager alloc] initWithUpdateBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation, BOOL *stop) {
        [self sendCoordinate:[newLocation toCoordinateDictionary] toId:facebookId];
        [manager stopUpdatingLocation];
    } errorBlock:^(NSError *error) {
        NSLog(@"Error updating location: %@", error);
    }];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}

- (void) user:(NSString *)facebookId didReportLocation:(NSDictionary *)location{
    for (id place in self.places)
        if ([[place placeType] isEqualToString:@"Friend"]){
            if ([[place friendId] isEqualToString:facebookId]) {
                [place setCoordinate: location];
                [place setIsLoaded:YES];
            }
    }
}

+ (WhereShouldWeMeet *) manager{
    @synchronized(self){
        if (_manager == NULL)
            _manager = [[WhereShouldWeMeet alloc] init];
    }
    return _manager;
}

  + (NSString *) host {
      return @"http://jmcohen.webfactional.com";
  }
  

@end
