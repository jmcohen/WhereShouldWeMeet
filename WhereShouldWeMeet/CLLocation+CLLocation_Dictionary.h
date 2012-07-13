//
//  CLLocation+CLLocation_Dictionary.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (CLLocation_Dictionary)

- (NSDictionary *) toCoordinateDictionary;

@end
