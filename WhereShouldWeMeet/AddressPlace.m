//
//  Address.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddressPlace.h"
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <CoreLocation/CLLocation.h>
#import "Location.h"

@implementation AddressPlace

@synthesize address;

- (id) initWithAddress:(NSString *)newAddress
{
    if (self = [super init])
    {
        address = newAddress;
    }
    return self;
}

- (void) loadLocation:(void (^)())completionBlock
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error)
     {
         //TODO: error handling
         if (placemarks.count > 0){
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             self.location = [[Location alloc] initWithCoordinate:placemark.location.coordinate];
             completionBlock();
         }
     }];
}

- (void) loadImage:(void (^)())completionBlock
{
    self.image = [UIImage imageNamed:@"house.png"];
    completionBlock();
}


- (NSString *) description
{
    return self.address;
}

@end
