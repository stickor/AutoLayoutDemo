//
//  CodeTableViewCell.h
//  AutoLayoutDemo
//
//  Created by 杨引 on 2021/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeTableViewCell : UITableViewCell

- (void)updateWithImageUrlPath:(NSString *)urlPath text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
