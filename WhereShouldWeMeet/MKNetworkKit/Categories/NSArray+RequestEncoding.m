//
//  NSString+RequestEncoding.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 8/5/12.
//
//

#import "NSArray+RequestEncoding.h"

@implementation NSArray (RequestEncoding)


-(NSString*) jsonEncodedKeyValueString {
    NSError *error = nil;
    NSData *data = [NSClassFromString(@"NSJSONSerialization") dataWithJSONObject:self
                                                                         options:0 // non-pretty printing
                                                                           error:&error];
    if(error)
        DLog(@"JSON Parsing Error: %@", error);
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
