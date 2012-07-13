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
    
    UILabel *nameLabel, *phoneLabel, *addressLabel;
}

@property (nonatomic, strong) NSArray *venues;
@property (nonatomic) NSInteger currentVenueIndex;
@property (nonatomic, strong) NSDictionary *currentVenue;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;

- (IBAction)nextVenue:(id)sender;
- (void) venuesLoaded;


@end
