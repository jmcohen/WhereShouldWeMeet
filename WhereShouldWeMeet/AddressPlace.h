//
//  Address.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface AddressPlace : Place {
    NSString *address;
}

@property (nonatomic, strong) NSString *address;

- (id) initWithAddress: (NSString *) address;

@end
