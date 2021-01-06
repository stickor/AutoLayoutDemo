//
//  SBTableViewCell.h
//  AutoLayoutDemo
//
//  Created by 杨引 on 2021/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBTableViewCell : UITableViewCell

- (void)updateWithImageUrlPath:(NSString *)urlPath text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
