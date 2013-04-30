//
//  Place.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import <MapKit/MKAnnotation.h>

@interface Place : NSObject <MKAnnotation> {
    Location *location;
    UIImage *image;
}

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

- (NSString *) description;
- (void) loadLocation: (void (^)())completionBlock;
- (void) loadImage:(void (^)())completionBlock;

@end
