//
//  CityGridEngine.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKNetworkEngine.h"

@class Location;

@interface LocalSearchEngine : MKNetworkEngine

typedef void (^GetVenuesBlock)(NSArray *venues);
typedef void (^NoVenuesBlock)();

- (MKNetworkOperation *) getVenuesForLocation: (Location *) location radius: (NSNumber *) radius selectedCategories: (NSArray *) selectedCategories onSuccess: (GetVenuesBlock) getVenuesBlock onEmpty:(NoVenuesBlock) noVenuesBlock;

+ (NSArray *) categories;
+ (NSArray *) categoryIds;
+ (NSDictionary *) categoriesToCategoryIds;

@end
