//
//  ShowVenueViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>

@class Venue;

@interface ShowVenueViewController : UIViewController <MKMapViewDelegate>{
    NSArray *venues;
    NSInteger currentVenueIndex;
    Venue *currentVenue;
    
    MKMapView *mapView;
    UINavigationBar *navigationBar;
}

@property (nonatomic, strong) NSArray *venues;
@property (nonatomic) NSInteger currentVenueIndex;
@property (nonatomic, strong) Venue *currentVenue;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UINavigationBar *navigationBar;

- (IBAction)nextVenue:(id)sender;
- (IBAction)broadcast:(id)sender;
- (IBAction)directions:(id)sender;

- (void) venuesLoaded;


@end
