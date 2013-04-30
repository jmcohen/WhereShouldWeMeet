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
#import <FBiOSSDK/FacebookSDK.h>
#import "MKNetworkEngine.h"

@implementation FriendLocationPlace

@synthesize friend;

- (id) initWithFriend:(id<FBGraphUser>)theFriend
{
    if (self = [super init])
    {
        self.friend = theFriend;
    }
    return self;
}

- (void) loadLocation:(void (^)())completionBlock
{
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    [appDelegate.friendsLocationEngine requestFriendLocation:self.friend.id];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationReportReceived:) name:@"DidReceiveLocationReport" object:nil];
    
    locationLoadCompletionBlock = completionBlock;
}
     
- (void) locationReportReceived: (NSNotification *) userInfo
{
    NSDictionary *locationReport = [userInfo userInfo];
    
    NSString *user = [locationReport objectForKey:@"id"];
    
    if ([self.friend.id isEqualToString:user])
    {
        NSString *locationJson = [locationReport objectForKey:@"location"];
        
        self.location = [[Location alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:[locationJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]];
    
        locationLoadCompletionBlock();
    }
}
     
- (void) loadImage:(void (^)())completionBlock
{
    self.image = [UIImage imageNamed:@"person.png"];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    [appDelegate.friendsLocationEngine requestFriendLocation:self.friend.id];
    
    [appDelegate.facebookEngine imageAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=normal&access_token=%@", self.friend.id, [FBSession activeSession].accessToken]] onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        self.image = fetchedImage;
        completionBlock();
    }];
}

- (NSString *) description
{
    return self.friend.name;
}


@end
