//
//  AddFriendLocationViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendLocationViewController : UITableViewController {
    NSDictionary *selectedFriend;
}

@property (nonatomic, retain) NSDictionary *selectedFriend;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
