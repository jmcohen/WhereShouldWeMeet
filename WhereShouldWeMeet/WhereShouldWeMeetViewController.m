//
//  WhereShouldWeMeetViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WhereShouldWeMeetViewController.h"
#import "WhereShouldWeMeet.h"
#import "Place.h"
#import "AddressPlace.h"
#import "FriendLocationPlace.h"
#import "MyLocationPlace.h"

@interface WhereShouldWeMeetViewController ()

@end

@implementation WhereShouldWeMeetViewController

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
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor yellowColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"PlaceLoaded" object:nil];

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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [[WhereShouldWeMeet manager].places count];
    else if (section == 1)
        return 1;
    else if (section == 2)
        return 1;
    else 
        return 1;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Who?";
    else if (section == 2)
        return @"Where?";
    return nil;
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0)
        if ([[WhereShouldWeMeet manager].places count] == 0)
            return @"You have not added any places yet.";
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0){
        WhereShouldWeMeet *manager = [WhereShouldWeMeet manager];
        Place *place = [manager.places objectAtIndex:indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
        UILabel *textLabel = (UILabel *) [cell viewWithTag:1];
        textLabel.text = [place placeType];
        UILabel *detailTextLabel = (UILabel *) [cell viewWithTag:2];
        detailTextLabel.text = [place description];
        UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *) [cell viewWithTag:3];
        if ([place isLoaded]){
            detailTextLabel.textColor = [UIColor blackColor];
            [activityIndicator stopAnimating];
        } else {
            detailTextLabel.textColor = [UIColor grayColor];
            [activityIndicator startAnimating];
        }
    } else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddPlaceCell"];
    } else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        cell.textLabel.text =[WhereShouldWeMeet manager].category;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"GoCell"];
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return YES;
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[WhereShouldWeMeet manager].places removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}

- (void)addPlace {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose one" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Address", @"Add Contact", @"Add My Location", @"Add Friend's Location", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1){
        if (buttonIndex == 0){
            [self performSegueWithIdentifier:@"AddAddress" sender:self];
        } else if (buttonIndex == 1){
            [[WhereShouldWeMeet manager].places addObject: [[MyLocationPlace alloc] init]];
        }else if (buttonIndex == 2)
            [self performSegueWithIdentifier:@"AddFriendLocation" sender:self];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
        [self addPlace];
    if (indexPath.section == 3){
        [self performSegueWithIdentifier:@"Go" sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
