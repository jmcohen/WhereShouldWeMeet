//
//  AddFriendLocationViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBiOSSDK/FacebookSDK.h>

@interface AddFriendLocationViewController : FBFriendPickerViewController <FBFriendPickerDelegate> {
}

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
