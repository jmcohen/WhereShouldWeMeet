//
//  AppDelegate.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Facebook;
@class FriendsLocationEngine;
@class LocalSearchEngine;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    NSString *deviceToken;
    FriendsLocationEngine *friendsLocationEngine;
    LocalSearchEngine *localSearchEngine;
    MKNetworkEngine *facebookEngine;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FriendsLocationEngine *friendsLocationEngine;
@property (strong, nonatomic) LocalSearchEngine *localSearchEngine;
@property (strong, nonatomic) MKNetworkEngine *facebookEngine;
@property (strong, nonatomic) NSString *deviceToken;

@end
