//
//  SBTableViewCell.m
//  AutoLayoutDemo
//
//  Created by 杨引 on 2021/1/6.
//

#import "SBTableViewCell.h"
#import <SDWebImage/SDWebImage.h>


@interface SBTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end


@implementation SBTableViewCell

- (void)updateWithImageUrlPath:(NSString *)urlPath text:(NSString *)text {
    __weak __typeof(self)weakSelf = self;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlPath] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong __typeof(weakSelf)self = weakSelf;
        self.imageViewHeight.constant = image.size.height/8.0;
        self.imageViewWidth.constant = image.size.width/8.0;
    }];
    self.describeLabel.text = text;
}

@end
