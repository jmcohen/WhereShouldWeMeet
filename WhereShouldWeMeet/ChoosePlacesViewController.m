//
//  ChoosePlacesViewController2.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/24/12.
//
//

#import "ChoosePlacesViewController.h"
#import "PlaceCell.h"
#import "WhereShouldWeMeet.h"
#import "Place.h"
#import "MyLocationPlace.h"
#import "UIImage+StackBlur.h"

@interface ChoosePlacesViewController ()

@end

@implementation ChoosePlacesViewController

@synthesize collectionView;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newPlace) name:@"NewPlace" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoaded) name:@"ReloadPlacesData" object:nil];
    
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    [super viewDidLoad];
}

- (void) dataLoaded
{
    [self.collectionView reloadData];
}

- (void) newPlace
{
    [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:
                                                  [NSIndexPath indexPathForRow:[WhereShouldWeMeet manager].places.count
                                                                     inSection:0]]];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[WhereShouldWeMeet manager].places.count inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [WhereShouldWeMeet manager].places.count + 1;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == [self collectionView:cv numberOfItemsInSection:indexPath.section] - 1)
    {
        UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"AddPlaceCell" forIndexPath:indexPath];
        cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.layer.borderColor = [UIColor blueColor].CGColor;
        cell.selectedBackgroundView.layer.borderWidth = 4.0f;
        return cell;
    }
    else
    {
        PlaceCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"PlaceCell" forIndexPath:indexPath];
        Place *place = [[WhereShouldWeMeet manager].places objectAtIndex:indexPath.item];
        cell.titleLabel.text = place.title;
        cell.imageView.backgroundColor = [UIColor colorWithPatternImage: place.location? place.image : [place.image stackBlur:3]];
        
        if (!place.location){
            [cell.activityIndicator startAnimating];
        } else {
            [cell.activityIndicator stopAnimating];
        }
        
        CALayer *layer = cell.imageView.layer;
        [layer setCornerRadius:20];
        
        return cell;
    }
}

- (BOOL) collectionView:(UICollectionView *)cv shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == [self collectionView:cv numberOfItemsInSection:indexPath.section] - 1)
    {
        return YES;
    }
    return NO;
}

- (void) collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showAddPlaceActionSheet];
    [cv deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)showAddPlaceActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose one" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Address", @"My Location", @"Friend's Location", nil];
    actionSheet.tag = 1;
    [actionSheet showInView: self.parentViewController.view];
}

- (void) addMyLocation
{
    MyLocationPlace *place = [[MyLocationPlace alloc] init];
    [[WhereShouldWeMeet manager].places addObject:place];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPlace" object:nil];

    void (^load)() = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadPlacesData" object:nil];
    };
    [place loadLocation:load];
    [place loadImage:load];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1){
        if (buttonIndex == 0){
            [self performSegueWithIdentifier:@"AddAddress" sender:self];
        } else if (buttonIndex == 1){
            [self addMyLocation];
        }else if (buttonIndex == 2){
            [self performSegueWithIdentifier:@"AddFriend" sender:self];
        }
    }
}

@end
