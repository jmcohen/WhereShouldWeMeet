//
//  FriendLocation.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import <FBiOSSDK/FacebookSDK.h>

@class MKNetworkOperation;

@interface FriendLocationPlace : Place {
    id<FBGraphUser> friend;
    MKNetworkOperation *imageLoadOperation;
    void (^locationLoadCompletionBlock)();
}

- (id) initWithFriend: (id<FBGraphUser>) theFriend;

@property (nonatomic, strong) id<FBGraphUser> friend;

@end
