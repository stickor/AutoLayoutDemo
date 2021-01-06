//
//  ViewController.m
//  AutoLayoutDemo
//
//  Created by 杨引 on 2021/1/6.
//

#import "ViewController.h"
#import "SBTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "MasonryViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong __typeof(weakSelf)self = weakSelf;
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Data.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:jsonPath];
        if (data) {
            NSError *error = nil;
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"\n%@", [error localizedDescription]);
            self.dataSource = result;
            [self.tableView reloadData];
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count-1;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SBTableViewCell";
    SBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *urlPath = self.dataSource[indexPath.row][@"image"];
    NSString *textStr = self.dataSource[indexPath.row][@"text"];
    [cell updateWithImageUrlPath:urlPath text:textStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---------");
    [self.navigationController pushViewController:[MasonryViewController new] animated:YES];
    
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

@end
