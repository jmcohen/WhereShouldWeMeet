//
//  FriendsLocationEngine.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKNetworkEngine.h"
#import <CoreLocation/CLLocation.h>

@class Location;
@class Venue;

@interface FriendsLocationEngine : MKNetworkEngine {
}

typedef void (^UserFriendsBlock)(NSArray *userFriends);


- (MKNetworkOperation *) registerUser: (NSString *)deviceToken;
- (MKNetworkOperation *) getUserFriendsOnCompletion: (UserFriendsBlock) userFriendsBlock;
- (MKNetworkOperation *) requestFriendLocation: (NSString *) friendId;
- (MKNetworkOperation *) broadcastVenue: (Venue *) location toFriends: (NSArray *) friendIds;
- (MKNetworkOperation *) reportLocation: (Location *) location toFriend: (NSString *) friendId;

@end
