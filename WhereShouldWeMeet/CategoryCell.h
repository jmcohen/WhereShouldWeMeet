//
//  CategoryCell.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/25/12.
//
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UICollectionViewCell {
    UIImageView *imageView;
    UILabel *titleLabel;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
