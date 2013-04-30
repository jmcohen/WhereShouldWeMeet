//
//  ChoosePlacesViewController2.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/24/12.
//
//

#import <UIKit/UIKit.h>

@interface ChoosePlacesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate> {
    UICollectionView *collectionView;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

- (void) dataLoaded;

@end
