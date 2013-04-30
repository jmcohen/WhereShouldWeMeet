//
//  PlaceCell2.h
//  WhereShouldWeMeet
//
//  Created by Jeremy Cohen on 7/24/12.
//
//

#import <UIKit/UIKit.h>

@interface PlaceCell : UICollectionViewCell {
    UIView *imageView;
    UILabel *titleLabel;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, strong) IBOutlet UIView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
