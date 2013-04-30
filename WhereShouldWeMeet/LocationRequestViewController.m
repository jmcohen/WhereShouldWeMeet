//
//  LocationRequestViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/28/12.
//
//

#import "LocationRequestViewController.h"
#import "AppDelegate.h"
#import "FriendsLocationEngine.h"
#import "Location.h"
#import "AddressPlace.h"
#import "MyLocationPlace.h"

@interface LocationRequestViewController ()

@end

@implementation LocationRequestViewController

@synthesize scrollView, pictureView, promptLabel, addressField, sendAddressButton, sendLocationButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = self.scrollView.frame.size;
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.promptLabel.text = [NSString stringWithFormat:@"%@ wants to know your location.", requesterName];
    [self.promptLabel sizeToFit];
    
    self.pictureView.pictureCropping = FBProfilePictureCroppingOriginal;
    self.pictureView.userID = requesterId;
    
    // Dismiss the keyboard when the user taps outside.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:@"UIKeyboardDidShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:@"UIKeyboardDidHideNotification" object:nil];
}

- (void)keyboardDidShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    [scrollView setContentOffset:CGPointMake(0, kbSize.height) animated:YES];
}

- (void)keyboardDidHide:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) dismissKeyboard
{
    [self.addressField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self dismissKeyboard];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setRequester:(NSDictionary *)requester
{
    requesterId = [requester objectForKey:@"id"];
    requesterName = [requester objectForKey:@"name"];
}

- (void) reportPlace: (Place *) place
{
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    FriendsLocationEngine *engine = appDelegate.friendsLocationEngine;
    
    [place loadLocation:^{
        [engine reportLocation:place.location toFriend:requesterId];
    }];

}

- (IBAction)sendLocation:(id)sender
{
    [self reportPlace:[[MyLocationPlace alloc] init] ];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendAddress:(id)sender
{
    [self reportPlace:[[AddressPlace alloc] initWithAddress:self.addressField.text] ];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ignore:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Only allow portrait orientation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
