//
//  CodeTableViewCell.m
//  AutoLayoutDemo
//
//  Created by 杨引 on 2021/1/6.
//

#import "CodeTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "Masonry.h"

@interface CodeTableViewCell ()
@property (strong, nonatomic) UILabel *describeLabel;
@property (strong, nonatomic) UIImageView *imgView;
@end

@implementation CodeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutConstraint];
    }
    return self;
}

- (void)layoutConstraint {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeZero);
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
        make.left.equalTo(self.imgView);
        make.right.equalTo(self).mas_offset(-10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
}

- (void)updateWithImageUrlPath:(NSString *)urlPath text:(NSString *)text {
    __weak __typeof(self)weakSelf = self;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlPath] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong __typeof(weakSelf)self = weakSelf;
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(image.size.width/8.0, image.size.height/8.0));
        }];
    }];
    self.describeLabel.text = text;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        [self addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [UILabel new];
        _describeLabel.numberOfLines = 0;
        [self addSubview:_describeLabel];
    }
    return _describeLabel;
}

@end
