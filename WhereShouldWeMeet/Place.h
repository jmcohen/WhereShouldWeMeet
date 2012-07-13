//
//  Place.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@class Place;

@interface Place : NSObject {
    BOOL isLoaded;
    NSDictionary *coordinate;
}

@property (nonatomic) BOOL isLoaded;
@property (nonatomic, strong) NSDictionary *coordinate;

- (NSString *) description;
- (NSString *) placeType;

@end
