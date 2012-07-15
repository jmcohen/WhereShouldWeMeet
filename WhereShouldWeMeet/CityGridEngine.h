//
//  CityGridEngine.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKNetworkEngine.h"

@class Coordinate;

@interface CityGridEngine : MKNetworkEngine

typedef void (^GetVenuesBlock)(NSArray *venues);

- (MKNetworkOperation *) getVenuesForCoordinate: (Coordinate *) coordinate radius: (NSNumber *) radius category: (NSString *) category onSuccess: (GetVenuesBlock) getVenuesBlock;

@end
