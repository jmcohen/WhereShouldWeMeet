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
@synthesize nameLabel, phoneLabel, addressLabel;

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
    self.nameLabel.text = [self.currentVenue objectForKey:@"title"];
    self.addressLabel.text = [self.currentVenue objectForKey:@"address"];
    self.phoneLabel.text = [self.currentVenue objectForKey:@"phone"]; 
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.currentVenue objectForKey:@"link"]]];
    } else if (indexPath.row == 1){
        // TOOD
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
