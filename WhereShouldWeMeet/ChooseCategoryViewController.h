//
//  ChooseCategoryViewController.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCategoryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *collectionView;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end
