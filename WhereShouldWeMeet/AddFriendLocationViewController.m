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

@synthesize selectedFriend;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [[WhereShouldWeMeet manager] loadUserFriends];
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"UserFriendsLoaded" object:nil];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    NSDictionary *friend = [[WhereShouldWeMeet manager].userFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = [friend objectForKey:@"name"];
    if (friend == selectedFriend)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else 
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *friend = [[WhereShouldWeMeet manager].userFriends objectAtIndex:indexPath.row];
    if (selectedFriend == friend)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    else {
        NSIndexPath *old = [NSIndexPath indexPathForRow:[[WhereShouldWeMeet manager].userFriends indexOfObject:selectedFriend] inSection:0];
        selectedFriend = friend;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:old, indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)done:(id)sender{
    if (self.selectedFriend){
        [[WhereShouldWeMeet manager].places addObject: [[FriendLocationPlace alloc] initWithFriend:self.selectedFriend]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
