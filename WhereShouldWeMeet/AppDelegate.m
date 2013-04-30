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
#import "LocalSearchEngine.h"
#import "Location.h"
#import <FBiOSSDK/FacebookSDK.h>
#import <MapKit/MKMapItem.h>
#import "LocationRequestViewController.h"
#import "UIAlertView+Blocks.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize deviceToken;
@synthesize friendsLocationEngine, localSearchEngine, facebookEngine;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    [FBSession sessionOpenWithPermissions:nil completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        if (self.deviceToken)
            [friendsLocationEngine registerUser:self.deviceToken];
    }];
    
    friendsLocationEngine = [[FriendsLocationEngine alloc] initWithHostName:@"jmcohen.webfactional.com"];
    
    localSearchEngine = [[LocalSearchEngine alloc] initWithHostName:@"maps.googleapis.com"];
    
    facebookEngine = [[MKNetworkEngine alloc] initWithHostName:@"graph.facebook.com"];
    

    
    NSNotification *notification =
    [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification)
    {
        [self application:application didReceiveRemoteNotification:notification.userInfo];
    }
    
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    self.deviceToken = [[[devToken description]
                    stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
                   stringByReplacingOccurrencesOfString:@" " 
                   withString:@""];
    if ([FBSession activeSession].accessToken)
        [friendsLocationEngine registerUser: self.deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"Error in registration. Error: %@", err);
}

- (void) application: (UIApplication *) app didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *type = [userInfo objectForKey:@"type"];
    if ([type isEqualToString:@"LocationRequest"]) {
        [self presentLocationRequest:[userInfo objectForKey:@"locationRequest"]];
    }
    else if ([type isEqualToString:@"LocationReport"]) {
          [[NSNotificationCenter defaultCenter] postNotificationName:@"DidReceiveLocationReport" object:nil userInfo:[userInfo objectForKey:@"locationReport"]];
    }
    else if ([type isEqualToString:@"Broadcast"]){
        NSDictionary *broadcast = [userInfo objectForKey:@"broadcast"];
        NSDictionary *locationDict = [NSJSONSerialization JSONObjectWithData:[[broadcast objectForKey:@"venueLocation"] dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];
        NSString *venueName = [broadcast objectForKey:@"venueName"];
        NSString *broadcaster = [broadcast objectForKey:@"broadcaster"];
        Location *venueLocation = [[Location alloc] initWithDictionary:locationDict];
        [UIAlertView displayAlertWithTitle:[NSString stringWithFormat: @"%@ has broadcasted a meeting location.", broadcaster]
                                   message:nil
                           leftButtonTitle:@"Cancel"
                          leftButtonAction:^{}
                          rightButtonTitle:@"Show"
                         rightButtonAction:^{
                             MKMapItem *venueItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:[venueLocation asCoordinate] addressDictionary:nil]];
                             venueItem.name = venueName;
                             MKMapItem *currentLocationItem = [MKMapItem mapItemForCurrentLocation];
                             currentLocationItem.name = @"My Location";
                             [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocationItem, venueItem, nil]
                                            launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsDirectionsModeKey, nil]];
                         }];
    }
    
    app.applicationIconBadgeNumber = 0;
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
    return [FBSession.activeSession handleOpenURL:url]; 
}

- (void) presentLocationRequest: (NSDictionary *) locationRequest
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    LocationRequestViewController *locationRequestViewController = [storyboard instantiateViewControllerWithIdentifier:@"LocationRequestController"];
    
    
    [locationRequestViewController setRequester:locationRequest];
    
    UIViewController *currentViewController = self.window.rootViewController.modalViewController == nil ? self.window.rootViewController : self.window.rootViewController.modalViewController;
    
    [currentViewController presentModalViewController:locationRequestViewController animated:YES];
}


@end
