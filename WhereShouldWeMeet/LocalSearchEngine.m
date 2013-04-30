//
//  CityGridEngine.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalSearchEngine.h"
#import "Location.h"
#import "Venue.h"

@implementation LocalSearchEngine

- (MKNetworkOperation *) getVenuesForLocation:(Location *)location radius:(NSNumber *)radius selectedCategories:(NSArray *)selectedCategories onSuccess:(GetVenuesBlock)getVenuesBlock onEmpty:(NoVenuesBlock)noVenuesBlock {
    NSString *key = @"AIzaSyCvGXBycjMdz-2DAsmXiWWZl6vQgBJFjJo";
    NSArray *ids = [[LocalSearchEngine categoriesToCategoryIds] objectsForKeys:selectedCategories notFoundMarker:@"type-not-found"];
    NSString *categoriesString = [ids componentsJoinedByString:@"|"];
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"maps/api/place/search/json"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        categoriesString, @"types",
                                                        [location asComma], @"location",
                                                        radius, @"radius",
                                                        @"true", @"sensor",
                                                        key, @"key",
                                                        nil]
                                          httpMethod:@"GET" ssl:YES];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSArray *results = [completedOperation.responseJSON objectForKey:@"results"];
        if (results.count == 0){
            noVenuesBlock();
        } else {
        NSMutableArray *venues = [NSMutableArray array];
        for (NSDictionary *result in results){
            Venue *venue = [[Venue alloc] init];
            venue.name = [result objectForKey:@"name"];
            venue.address = [result objectForKey:@"vicinity"];
            venue.rating = [result objectForKey:@"rating"];
            NSDictionary *location = [[result objectForKey:@"geometry"] objectForKey:@"location"];
            venue.location = [[Location alloc] initWithLatitude:((NSString *) [location objectForKey:@"lat"]).doubleValue 
                                                      longitude:((NSString *)[location objectForKey:@"lng"]).doubleValue];
            [venues addObject:venue];
            }
        getVenuesBlock(venues);
        }
    } onError:^(NSError *error) {
        NSLog(@"Error in getting venues: %@", error);
    }];
    [self enqueueOperation:op];
    return op;  
}

+ (NSArray *) categories {
    return [NSArray arrayWithObjects: @"Bar", @"Beauty Salon", @"Book Store", @"Bowling Alley", @"Cafe", @"Department Store", @"Movie Theater", @"Museum", @"Night Club", @"Park", @"Shopping Mall", nil];
}

+ (NSArray *) categoryIds {
    return [NSArray arrayWithObjects:@"bar", @"beauty_salon", @"book_store", @"bowling_alley", @"cafe", @"department_store", @"movie_theater", @"museum", @"night_club", @"park", @"shopping_mall", nil];
}

+ (NSDictionary *) categoriesToCategoryIds {
    return [NSDictionary dictionaryWithObjects:[self categoryIds] forKeys:[self categories]];
}

@end
