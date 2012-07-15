//
//  AppDelegate.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "WhereShouldWeMeet.h"
#import "UIAlertView+Blocks.h"
#import "FriendsLocationEngine.h"
#import "CityGridEngine.h"
#import "Coordinate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize deviceToken;
@synthesize friendsLocationEngine, cityGridEngine;
@synthesize facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    facebook = [[Facebook alloc] initWithAppId:@"316475088442311" andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid])
        [facebook authorize:nil];
    
    
    friendsLocationEngine = [[FriendsLocationEngine alloc] initWithHostName:@"jmcohen.webfactional.com"];
    friendsLocationEngine.facebook = self.facebook;
    
    cityGridEngine = [[CityGridEngine alloc] initWithHostName:@"api.citygridmedia.com"];
            
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    self.deviceToken = [[[devToken description]
                    stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
                   stringByReplacingOccurrencesOfString:@" " 
                   withString:@""];
    [self.friendsLocationEngine registerUser: deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void) application: (UIApplication *) app didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSString *type = [userInfo objectForKey:@"type"];
    if ([type isEqualToString:@"LocationRequest"]){
        [UIAlertView displayAlertWithTitle:[NSString stringWithFormat:@"%@ wishes to know your location.", [userInfo objectForKey:@"name"]]
                                    message:nil
                            leftButtonTitle:@"Allow" 
                          leftButtonAction:^{ [[WhereShouldWeMeet manager] reportLocationToFriend: [userInfo objectForKey: @"id"]];}
                          rightButtonTitle:@"Decline"
                         rightButtonAction:^(){}];
    } else if ([type isEqualToString:@"LocationReport"]){
        NSString *user = [userInfo objectForKey:@"id"];
        NSString *locationJson = [userInfo objectForKey:@"location"];
        Coordinate *location = [[Coordinate alloc] initWithJson:locationJson];
        [[WhereShouldWeMeet manager] user: user didReportLocation: location];
    }
}

- (void) fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:facebook.accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:facebook.expirationDate forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook  handleOpenURL:url]; 
}

@end
