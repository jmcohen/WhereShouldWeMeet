//
//  Place.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize location, image;

- (NSString *) description {
    return nil;
}

- (CLLocationCoordinate2D) coordinate {
    return [self.location asCoordinate];
}

- (NSString *) title{
    return [self description];
}

- (NSString *) subtitle {
    return [self.location description];
}

- (void) loadLocation:(void (^)())completionBlock {
    
}

- (void) loadImage:(void (^)())completionBlock  {
    
}

@end
