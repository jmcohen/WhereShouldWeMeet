//
//  FlipLeftSegue.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/28/12.
//
//

#import "FlipBottomSegue.h"
#import "AppDelegate.h"

@implementation FlipBottomSegue

- (void) perform {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *source = (UIViewController *) self.sourceViewController;
    UIViewController *destination = (UIViewController *) self.destinationViewController;
    [UIView transitionFromView:source.view
                        toView:destination.view
                      duration:.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    completion:^(BOOL finished) {
                        delegate.window.rootViewController = destination;
                    }];
    
}


@end
