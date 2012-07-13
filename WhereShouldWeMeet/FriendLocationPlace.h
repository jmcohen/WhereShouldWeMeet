//
//  FriendLocation.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface FriendLocationPlace : Place {
    NSString *friendName;
    NSString *friendId;
}

@property (nonatomic, strong) NSString *friendName;
@property (nonatomic, strong) NSString *friendId;

- (id) initWithFriend: (NSDictionary *) friend;

@end
