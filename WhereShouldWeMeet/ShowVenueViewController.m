//
//  ShowVenueViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowVenueViewController.h"
#import "WhereShouldWeMeet.h"
#import "Venue.h"
#import "FriendsLocationEngine.h"
#import "FriendLocationPlace.h"
#import "AppDelegate.h"
#import <MapKit/MKMapItem.h>

@interface ShowVenueViewController ()

@end

@implementation ShowVenueViewController

@synthesize venues, currentVenue, currentVenueIndex;
@synthesize mapView, navigationBar;

- (void)viewDidLoad
{
    [[WhereShouldWeMeet manager] loadVenues];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(venuesLoaded) name:@"VenuesLoaded" object:nil];
    
    [self.mapView addAnnotations:[WhereShouldWeMeet manager].places];
    
    [super viewDidLoad];
}

- (void) setVenueIndex: (NSInteger) nextVenueIndex
{
    if (self.currentVenue)
        [self.mapView removeAnnotation:self.currentVenue];
    
    self.currentVenueIndex = nextVenueIndex;
    self.currentVenue = [self.venues objectAtIndex:currentVenueIndex];
    
    [[self.navigationBar.items objectAtIndex:0] setTitle: self.currentVenue.name];
    
    CLLocationCoordinate2D center = [self.currentVenue.location asCoordinate];
    MKCoordinateSpan span = [Location span:[WhereShouldWeMeet manager].locations];
    
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
    [self.mapView addAnnotation:self.currentVenue];
    [self.mapView selectAnnotation:self.currentVenue animated:YES];
}

- (void) venuesLoaded
{
    self.venues = [WhereShouldWeMeet manager].venues;
    if (self.venues.count > 0)
        [self setVenueIndex:0];
}

- (IBAction)nextVenue:(id)sender
{
    if (self.venues.count > 0)
        [self setVenueIndex: (self.currentVenueIndex + 1) % self.venues.count];
}

- (IBAction)broadcast:(id)sender
{
    NSArray *allPlaces = [WhereShouldWeMeet manager].places;
    NSMutableArray *friends = [NSMutableArray array];
    for (Place *place in allPlaces){
        if ([place isKindOfClass:[FriendLocationPlace class]]){
            [friends addObject: ((FriendLocationPlace *) place).friend.id];
        }
    }
    [((AppDelegate *)[UIApplication sharedApplication].delegate).friendsLocationEngine broadcastVenue:self.currentVenue toFriends:friends];
}

- (IBAction)directions:(id)sender
{
    MKMapItem *venueItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.currentVenue.coordinate addressDictionary:nil]];
    venueItem.name = self.currentVenue.name;
    MKMapItem *currentLocationItem = [MKMapItem mapItemForCurrentLocation];
    currentLocationItem.name = @"My Location";
    [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocationItem, venueItem, nil]
                   launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsDirectionsModeKey, nil]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}


@end
