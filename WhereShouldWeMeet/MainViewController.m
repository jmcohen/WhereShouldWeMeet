//
//  MainViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "ChoosePlacesViewController.h"
#import "ChooseCategoryViewController.h"

#define kWhoController 0
#define kWhereController 1

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize goButton, switchControl, subview;
@synthesize whoController, whereController;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        self.whoController = [storyboard instantiateViewControllerWithIdentifier:@"WhoController"];
        self.whereController = [storyboard instantiateViewControllerWithIdentifier:@"WhereController"];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:whoController];
    [self addChildViewController:whereController];
    [whoController didMoveToParentViewController:self];
    [whereController didMoveToParentViewController:self];
    
    whoController.view.frame = self.subview.bounds;
    whereController.view.frame = self.subview.bounds;
    
    currentViewController = kWhoController;
    [self.subview addSubview:whoController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    whoController.view.frame = self.subview.bounds;
    whereController.view.frame = self.subview.bounds;
     [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

}


- (IBAction)switchViews:(id)sender{
    UIViewController *old;
    UIViewController *new;
    
    NSUInteger animation;
    
    if (currentViewController == kWhoController){
        old = self.whoController;
        new = self.whereController;
        currentViewController = kWhereController;
        animation = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        old = self.whereController;
        new = self.whoController;
        currentViewController = kWhoController;
        animation = UIViewAnimationOptionTransitionFlipFromRight;
    }
    
    [UIView transitionFromView:old.view toView:new.view duration:.4 options:animation completion:nil];
    
}

@end
