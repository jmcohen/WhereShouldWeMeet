//
//  FriendsLocationEngine.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKNetworkEngine.h"

@class Facebook;
@class Coordinate;

@interface FriendsLocationEngine : MKNetworkEngine {
    Facebook *facebook;
}

typedef void (^UserFriendsBlock)(NSArray *userFriends);

@property (strong, nonatomic) Facebook *facebook;

- (MKNetworkOperation *) registerUser: (NSString *)deviceToken;
- (MKNetworkOperation *) getUserFriendsOnCompletion: (UserFriendsBlock) userFriendsBlock;
- (MKNetworkOperation *) requestFriendLocation: (NSString *) friendId;
- (MKNetworkOperation *) reportCoordinate: (Coordinate *) coordinate toFriend: (NSString *) friendId;

@end
