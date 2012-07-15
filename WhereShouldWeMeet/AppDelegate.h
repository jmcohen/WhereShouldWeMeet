//
//  AppDelegate.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class Facebook;
@class FriendsLocationEngine;
@class CityGridEngine;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, FBSessionDelegate> {
    NSString *deviceToken;
    FriendsLocationEngine *friendsLocationEngine;
    CityGridEngine *cityGridEngine;
    Facebook *facebook;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Facebook *facebook;
@property (strong, nonatomic) FriendsLocationEngine *friendsLocationEngine;
@property (strong, nonatomic) CityGridEngine *cityGridEngine;
@property (strong, nonatomic) NSString *deviceToken;

@end
