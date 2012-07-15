//
//  AddAddressViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
    UITableView *tableView;
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *doneButton;
    
    NSString *address;
}

@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *address;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
