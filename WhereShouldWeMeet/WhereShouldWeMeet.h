//
//  WhereShouldWeMeet.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "Place.h"
#import <CoreLocation/CLLocationManagerDelegate.h>

@class CLLocationManager;

@interface WhereShouldWeMeet : NSObject <FBSessionDelegate, NSURLConnectionDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    
    NSMutableArray *places;
    NSString *category;
    
    NSArray *categories;
    
    Facebook *facebook;
    NSString *deviceToken;
    
    NSArray *userFriends;
    NSArray *venues;
}

@property (nonatomic, strong) NSMutableArray *places;
@property (nonatomic, strong) NSArray *categories; 
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) Facebook *facebook;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSArray *userFriends;
@property (nonatomic, strong) NSArray *venues;

- (id) init;
- (void) registerUser;
- (void) loadUserFriends;
- (void) reportLocationToId: (NSString*) facebookId;
- (void) user: (NSString *) facebookId didReportLocation: (NSDictionary *) location;
- (void) loadVenues;

+ (WhereShouldWeMeet *) manager;
+ (NSString *) host;

@end
