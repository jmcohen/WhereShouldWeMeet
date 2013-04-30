//
//  Venue.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Venue.h"
#import "Location.h"

@implementation Venue 

@synthesize name, address, rating, location;

- (CLLocationCoordinate2D) coordinate {
    return [self.location asCoordinate];
}

- (NSString *) subtitle {
    return self.address;
}

- (NSString *) title {
    return self.name;
}

@end
