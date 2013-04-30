//
//  MyLocationPlace.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLocationPlace.h"
#import "CLLocationManager+blocks.h"
#import "Location.h"
#import "AppDelegate.h"
#import "FriendsLocationEngine.h"
#import <FBiOSSDK/FBSession.h>

@implementation MyLocationPlace

- (id) init
{
    return [super init];
}

- (void) loadLocation:(void (^)())completionBlock
{
    locationManager = [[CLLocationManager alloc] initWithUpdateBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation, BOOL *stop)
    {
        self.location = [[Location alloc] initWithCoordinate:newLocation.coordinate];
        [manager stopUpdatingLocation];
        completionBlock();
    }
        errorBlock:^(NSError *error){}];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}

- (void) loadImage:(void (^)())completionBlock
{
    self.image = [UIImage imageNamed:@"person.png"];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.facebookEngine imageAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me/picture?type=normal&access_token=%@",[FBSession activeSession].accessToken]] onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache)
     {
         self.image = fetchedImage;
         completionBlock();
     }];
}

- (NSString *) description
{
    return @"My Location";
}

@end
