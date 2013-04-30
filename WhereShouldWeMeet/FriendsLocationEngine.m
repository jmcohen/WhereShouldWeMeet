//
//  FriendsLocationEngine.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsLocationEngine.h"
#import "Location.h"
#import "Venue.h"
#import "MKNetworkOperation.h"
#import <FBiOSSDK/FacebookSDK.h>

@implementation FriendsLocationEngine

- (MKNetworkOperation *) registerUser:(NSString *)deviceToken
{
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"registerUser"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:deviceToken, @"deviceToken", [FBSession activeSession].accessToken, @"accessToken", nil]
                                          httpMethod:@"GET"];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) getUserFriendsOnCompletion: (UserFriendsBlock) userFriendsBlock
{
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"getUserFriends"]
                                              params:[NSDictionary dictionaryWithObject: [FBSession activeSession].accessToken forKey:@"accessToken"]
                                          httpMethod:@"GET"];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSArray *userFriends = completedOperation.responseJSON;
        userFriendsBlock(userFriends);
    } onError:^(NSError *error) {
        NSLog(@"Error in getting user friends: %@", error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) requestFriendLocation:(NSString *)friendId
{
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"requestLocation"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys: [FBSession activeSession].accessToken, @"accessToken", friendId, @"id", nil]
                                          httpMethod:@"GET"];
    NSLog(@"url: %@", [op url]);
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) reportLocation:(Location *)location toFriend:(NSString *)friendId
{
    NSString *locationJson = [[location asDictionary] jsonEncodedKeyValueString];
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"reportLocation"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys: [FBSession activeSession].accessToken, @"accessToken", friendId, @"id", locationJson, @"location", nil]
                                          httpMethod:@"GET"];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) broadcastVenue:(Venue *)venue toFriends:(NSArray *)friendIds
{
    NSString *venueLocationJson = [[venue.location asDictionary] jsonEncodedKeyValueString];
    NSString *venueName = venue.name;
    NSString *friendsJson = [friendIds jsonEncodedKeyValueString];
    MKNetworkOperation *op = [self operationWithPath:@"broadcastVenue"
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:[FBSession activeSession].accessToken, @"accessToken", venueLocationJson, @"venueLocation", venueName, @"venueName", friendsJson, @"friends",nil]
                                          httpMethod:@"GET"];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
            
    } onError:^(NSError *error) {
        NSLog(@"Error broadcasting venue: %@", error);
    }];
    [self enqueueOperation:op];
    return op;
}

@end
