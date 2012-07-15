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

@synthesize selectedFriend, tableView;

- (void)viewDidLoad
{
    WhereShouldWeMeet *manager = [WhereShouldWeMeet manager];
    if (manager.userFriends == nil)
        [manager loadUserFriends];
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"UserFriendsLoaded" object:nil];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[WhereShouldWeMeet manager].userFriends count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"FriendCell"];
    NSDictionary *friend = [[WhereShouldWeMeet manager].userFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = [friend objectForKey:@"name"];
    if (friend == selectedFriend)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else 
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *friend = [[WhereShouldWeMeet manager].userFriends objectAtIndex:indexPath.row];
    if (selectedFriend == friend)
        [tv deselectRowAtIndexPath:indexPath animated:YES];
    else {
        NSIndexPath *old = [NSIndexPath indexPathForRow:[[WhereShouldWeMeet manager].userFriends indexOfObject:selectedFriend] inSection:0];
        selectedFriend = friend;
        [tv reloadRowsAtIndexPaths:[NSArray arrayWithObjects:old, indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)done:(id)sender{
    if (self.selectedFriend){
        [[WhereShouldWeMeet manager].places addObject: [[FriendLocationPlace alloc] initWithFriend:self.selectedFriend]];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end
