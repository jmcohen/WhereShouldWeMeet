//
//  ShowVenueViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowVenueViewController : UITableViewController {
    NSArray *venues;
    NSInteger currentVenueIndex;
    NSDictionary *currentVenue;
}

@property (nonatomic, strong) NSArray *venues;
@property (nonatomic) NSInteger currentVenueIndex;
@property (nonatomic, strong) NSDictionary *currentVenue;

- (IBAction)nextVenue:(id)sender;
- (void) venuesLoaded;


@end
