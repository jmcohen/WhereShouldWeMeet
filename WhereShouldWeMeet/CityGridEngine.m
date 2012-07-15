//
//  CityGridEngine.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CityGridEngine.h"
#import "Coordinate.h"

@implementation CityGridEngine

- (MKNetworkOperation *) getVenuesForCoordinate:(Coordinate *)coordinate radius:(NSNumber *)radius category:(NSString *)category onSuccess:(GetVenuesBlock)getVenuesBlock {
    NSString *publisher = @"10000003691";
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"content/places/v2/search/latlon"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:category, @"what", coordinate.latitude, @"lat", coordinate.longitude, @"lon", radius, @"radius", @"json", @"format", @"topmatches", @"sort", publisher, @"publisher", nil]
                                          httpMethod:@"GET"];
    NSLog(@"url: %@", [op url]);
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSDictionary *results = completedOperation.responseJSON;
        NSArray *venues = [[results objectForKey:@"results"] objectForKey:@"locations"];
        getVenuesBlock(venues);
    } onError:^(NSError *error) {
        NSLog(@"Error in getting venues: %@", error);
    }];
    [self enqueueOperation:op];
    return op;  
}

@end
