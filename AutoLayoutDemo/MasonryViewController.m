//
//  MasonryViewController.m
//  AutoLayoutDemo
//
//  Created by 杨引 on 2021/1/6.
//

#import "MasonryViewController.h"
#import "CodeTableViewCell.h"
#import "Masonry.h"

@interface MasonryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.height.equalTo(self.view);
    }];
    
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    return self.dataSource.count -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CodeTableViewCell";
    CodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *urlPath = self.dataSource[indexPath.row][@"image"];
    NSString *textStr = self.dataSource[indexPath.row][@"text"];
    [cell updateWithImageUrlPath:urlPath text:textStr];
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 100;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CodeTableViewCell class] forCellReuseIdentifier:@"CodeTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

@end
