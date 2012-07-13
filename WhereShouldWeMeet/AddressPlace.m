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
#import "CLLocation+CLLocation_Dictionary.m"

@implementation AddressPlace

@synthesize address;

- (id) initWithAddress:(NSString *)newAddress {
    if (self = [super init]){
        address = newAddress;
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
            //TODO: error handling
            if (placemarks.count > 0){
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                self.coordinate = [placemark.location toCoordinateDictionary];
                self.isLoaded = YES;
            }
        }];
    }
    return self;
}


- (NSString *) description {
    return self.address;
}

- (NSString *) placeType {
    return @"Address";
}

@end
