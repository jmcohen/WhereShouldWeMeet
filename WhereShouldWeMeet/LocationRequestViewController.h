//
//  LocationRequestViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/28/12.
//
//

#import <UIKit/UIKit.h>
#import <FBiOSSDK/FBProfilePictureView.h>

@class Location;

@interface LocationRequestViewController : UIViewController <UITextFieldDelegate> {
    UIScrollView *scrollView;
    FBProfilePictureView *pictureView;
    UILabel *promptLabel;
    UITextField *addressField;
    UIButton *sendLocationButton;
    UIButton *sendAddressButton;
    
    NSString *requesterId;
    NSString *requesterName;
}

@property (nonatomic, strong) IBOutlet FBProfilePictureView *pictureView;
@property (nonatomic, strong) IBOutlet UILabel *promptLabel;
@property (nonatomic, strong) IBOutlet UITextField *addressField;
@property (nonatomic, strong) IBOutlet UIButton *sendLocationButton;
@property (nonatomic, strong) IBOutlet UIButton *sendAddressButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (void) setRequester: (NSDictionary *) requester;
- (void) dismissKeyboard;

- (IBAction)sendLocation:(id)sender;
- (IBAction)sendAddress:(id)sender;
- (IBAction)ignore: (id) sender;


@end
