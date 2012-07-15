//
//  ShowVenueViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowVenueViewController.h"
#import "WhereShouldWeMeet.h"

@interface ShowVenueViewController ()

@end

@implementation ShowVenueViewController

@synthesize venues, currentVenue, currentVenueIndex;

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
    [[WhereShouldWeMeet manager] loadVenues];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(venuesLoaded) name:@"VenuesLoaded" object:nil];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) setVenueIndex: (NSInteger) nextVenueIndex {
    self.currentVenueIndex = nextVenueIndex;
    self.currentVenue = [self.venues objectAtIndex:currentVenueIndex];
    [self.tableView reloadData];
}

- (void) venuesLoaded {
    self.venues = [WhereShouldWeMeet manager].venues;
    [self setVenueIndex:0];
}

- (IBAction)nextVenue:(id)sender{
    if (self.venues.count > 0)
        [self setVenueIndex: (self.currentVenueIndex + 1) % self.venues.count];
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.currentVenue)
        return 3;
    
    return 0;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
        cell.textLabel.text = [self.currentVenue valueForKey:@"name"];
        return cell;
    }
    if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
        cell.textLabel.text = [[self.currentVenue valueForKey:@"address"] valueForKey:@"street"];
        return cell;
    }
    if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneCell"];
        cell.textLabel.text = [self.currentVenue valueForKey:@"phone_number"];
        return cell;
    }    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
    } else if (indexPath.row == 1){
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
