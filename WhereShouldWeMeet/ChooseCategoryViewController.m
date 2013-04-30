//
//  ChooseCategoryViewController.m
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChooseCategoryViewController.h"
#import "WhereShouldWeMeet.h"
#import "CategoryCell.h"
#import "LocalSearchEngine.h"

@interface ChooseCategoryViewController ()

@end

@implementation ChooseCategoryViewController

@synthesize collectionView;

- (void)viewDidLoad
{
    
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.collectionView.allowsMultipleSelection = YES;

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (NSInteger) collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    return [WhereShouldWeMeet manager].categories.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    NSString *categoryId = [[LocalSearchEngine categoryIds] objectAtIndex:indexPath.item];
    NSString *categoryName = [[WhereShouldWeMeet manager].categories objectAtIndex:indexPath.item];
    cell.imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"person.png"]];
    cell.titleLabel.text = categoryName;
    
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];

    if ([[WhereShouldWeMeet manager].selectedCategories containsObject: categoryName]){
        cell.backgroundView.layer.borderColor = [UIColor blueColor].CGColor;
        cell.backgroundView.layer.borderWidth = 4.0f;
    }
    
    return cell;
}

- (void) collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WhereShouldWeMeet *manager = [WhereShouldWeMeet manager];
    NSString *selected = [manager.categories objectAtIndex:indexPath.item];
    if ([manager.selectedCategories containsObject:selected]){
        [manager.selectedCategories removeObject:selected];
    }
    else {
        [manager.selectedCategories addObject:selected];
    }
    [cv reloadData];
//    [cv reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

@end
