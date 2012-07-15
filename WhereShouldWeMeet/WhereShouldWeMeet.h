//
//  WhereShouldWeMeet.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import <CoreLocation/CLLocationManagerDelegate.h>

@class CLLocationManager;
@class AppDelegate;

@interface WhereShouldWeMeet : NSObject <NSURLConnectionDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    AppDelegate *appDelegate;
    
    NSMutableArray *places;
    NSString *category;
    
    NSArray *categories;
    NSArray *userFriends;
    NSArray *venues;
}

@property (nonatomic, strong) NSMutableArray *places;
@property (nonatomic, strong) NSArray *categories; 
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *userFriends;
@property (nonatomic, strong) NSArray *venues;
@property (nonatomic, strong) AppDelegate *appDelegate;

- (id) init;
- (void) loadUserFriends;
- (void) reportLocationToFriend: (NSString*) facebookId;
- (void) user: (NSString *) facebookId didReportLocation: (Coordinate *) location;
- (void) loadVenues;

+ (WhereShouldWeMeet *) manager;

@end
