//
//  FriendsLocationEngine.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsLocationEngine.h"
#import "Facebook.h"
#import "Coordinate.h"
#import "MKNetworkOperation.h"

@implementation FriendsLocationEngine

@synthesize facebook;

- (MKNetworkOperation *) registerUser:(NSString *)deviceToken {
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"registerUser"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:deviceToken, @"deviceToken", self.facebook.accessToken, @"accessToken", nil]
                                          httpMethod:@"GET"];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) getUserFriendsOnCompletion: (UserFriendsBlock) userFriendsBlock {
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"getUserFriends"]
                                              params:[NSDictionary dictionaryWithObject: self.facebook.accessToken forKey:@"accessToken"]
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

- (MKNetworkOperation *) requestFriendLocation:(NSString *)friendId {
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"requestLocation"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys: self.facebook.accessToken, @"accessToken", friendId, @"id", nil]
                                          httpMethod:@"GET"];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) reportCoordinate:(Coordinate *)coordinate toFriend: (NSString *) friendId{
    NSString *coordinateJson = [[coordinate asDictionary] jsonEncodedKeyValueString];
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"reportLocation"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys: self.facebook.accessToken, @"accessToken", friendId, @"id", coordinateJson, @"location", nil]
                                          httpMethod:@"GET"];
    [self enqueueOperation:op];
    return op;}

@end
