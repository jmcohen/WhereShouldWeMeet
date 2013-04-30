//
//  AddFriendLocationViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddFriendLocationViewController.h"
#import "WhereShouldWeMeet.h"
#import "FriendLocationPlace.h"

@interface AddFriendLocationViewController ()

@end

@implementation AddFriendLocationViewController

- (void)viewDidLoad
{
    WhereShouldWeMeet *manager = [WhereShouldWeMeet manager];
    if (manager.userFriends == nil)
        [manager loadUserFriends];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView) name:@"UserFriendsLoaded" object:nil];
    
    self.delegate = self;    
    [self loadData];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (BOOL) friendPickerViewController:(FBFriendPickerViewController *)friendPicker shouldIncludeUser:(id<FBGraphUser>)user{
    return [[WhereShouldWeMeet manager].userFriends containsObject:user.id];
}

- (IBAction)done:(id)sender{
    for (id<FBGraphUser> friend in self.selection)
    {
        FriendLocationPlace *place = [[FriendLocationPlace alloc] initWithFriend:friend];
        [[WhereShouldWeMeet manager].places addObject: place];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPlace" object:nil];

        void (^load)() = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadPlacesData" object:nil];
        };
        [place loadLocation:load];
        [place loadImage:load];
    }        
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end
