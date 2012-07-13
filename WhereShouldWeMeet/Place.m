//
//  Place.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize isLoaded, coordinate;

- (NSString *) description {
    return nil;
}

- (NSString *) placeType {
    return nil;
}

- (void) setIsLoaded:(BOOL)isNowLoaded {
    isLoaded = isNowLoaded;
    if (isLoaded)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlaceLoaded" object:self];
}

@end
