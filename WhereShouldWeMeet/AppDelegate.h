//
//  AppDelegate.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    NSString *deviceToken;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *deviceToken;

@end
