//
//  WhereShouldWeMeetViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoosePlacesViewController.h"
#import "WhereShouldWeMeet.h"
#import "Place.h"
#import "AddressPlace.h"
#import "FriendLocationPlace.h"
#import "MyLocationPlace.h"

@interface ChoosePlacesViewController ()

@end

@implementation ChoosePlacesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor yellowColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"PlaceLoaded" object:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
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
    return [[WhereShouldWeMeet manager].places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WhereShouldWeMeet *manager = [WhereShouldWeMeet manager];
    Place *place = [manager.places objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
    cell.textLabel.text = [place description];
//    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *) [cell viewWithTag:3];
    if ([place isLoaded]){
        cell.textLabel.textColor = [UIColor blackColor];
//        [activityIndicator stopAnimating];
    } else {
        cell.textLabel.textColor = [UIColor grayColor];
//        [activityIndicator startAnimating];
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[WhereShouldWeMeet manager].places removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}

- (IBAction)addPlace: (id) sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose one" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Address", @"Add My Location", @"Add Friend's Location", nil];
    actionSheet.tag = 1;
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1){
        if (buttonIndex == 0){
            [self performSegueWithIdentifier:@"AddAddressLocation" sender:self];
        } else if (buttonIndex == 1){
            [[WhereShouldWeMeet manager].places addObject: [[MyLocationPlace alloc] init]];
        }else if (buttonIndex == 2)
            [self performSegueWithIdentifier:@"AddFriendLocation" sender:self];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
