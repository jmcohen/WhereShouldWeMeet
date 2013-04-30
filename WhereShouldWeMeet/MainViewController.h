//
//  MainViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChoosePlacesViewController;
@class ChooseCategoryViewController;

@interface MainViewController : UIViewController {
    UIBarButtonItem *goButton;
    UISegmentedControl *switchControl;
    UIView *subview;
    
    ChoosePlacesViewController *whoController;
    ChooseCategoryViewController *whereController;
    int currentViewController;
} 

@property (nonatomic, strong) IBOutlet UIBarButtonItem *goButton;
@property (nonatomic, strong) IBOutlet UISegmentedControl *switchControl;
@property (nonatomic, strong) IBOutlet UIView *subview;
@property (nonatomic, strong) ChoosePlacesViewController *whoController;
@property (nonatomic, strong) ChooseCategoryViewController *whereController;

- (IBAction)switchViews:(id)sender;

@end
