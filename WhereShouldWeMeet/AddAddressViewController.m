//
//  AddAddressViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddAddressViewController.h"
#import "WhereShouldWeMeet.h"
#import "AddressPlace.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

@synthesize tableView, address, cancelButton, doneButton;

- (void)viewDidLoad
{
//    [self.addressField becomeFirstResponder];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)done:(id)sender
{
    AddressPlace *place = [[AddressPlace alloc] initWithAddress: address];
    [[WhereShouldWeMeet manager].places addObject:place];
    void (^load)() = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadPlacesData" object:nil];
    };
    [place loadLocation:load];
    [place loadImage:load];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Address";
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"AddressFieldCell"];
    UITextField *addressField = (UITextField *) [cell viewWithTag:1];
    [addressField becomeFirstResponder];
    return cell;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    self.doneButton.enabled = NO;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    self.address = textField.text;
    self.doneButton.enabled = YES;
}


@end