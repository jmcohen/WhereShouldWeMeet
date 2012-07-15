//
//  FriendLocation.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendLocationPlace.h"
#import "AppDelegate.h"
#import "FriendsLocationEngine.h"

@implementation FriendLocationPlace

@synthesize friendId, friendName;

- (id) initWithFriend:(NSDictionary *)friend {
    if (self = [super init]){
        friendId = [friend objectForKey:@"id"];
        friendName = [friend objectForKey:@"name"];
        FriendsLocationEngine *engine = ((AppDelegate *)[UIApplication sharedApplication].delegate).friendsLocationEngine;
        [engine requestFriendLocation:friendId];
    }
    return self;
}

- (NSString *) description {
    return self.friendName;
}

- (NSString *) placeType {
    return @"Friend";
}

@end
