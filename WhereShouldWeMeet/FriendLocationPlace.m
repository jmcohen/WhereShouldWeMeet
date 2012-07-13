//
//  FriendLocation.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendLocationPlace.h"
#import "WhereShouldWeMeet.h"

@implementation FriendLocationPlace

@synthesize friendId, friendName;

- (id) initWithFriend:(NSDictionary *)friend {
    if (self = [super init]){
        friendId = [friend objectForKey:@"id"];
        friendName = [friend objectForKey:@"name"];
        NSString *url = [NSString stringWithFormat:@"%@/requestLocation?accessToken=%@&id=%@", [WhereShouldWeMeet host], [WhereShouldWeMeet manager].facebook.accessToken, friendId];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request 
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){}];
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
