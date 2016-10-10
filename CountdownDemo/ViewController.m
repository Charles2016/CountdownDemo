//
//  ViewController.m
//  CountdownDemo
//
//  Created by Charles on 5/5/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "ViewController.h"
#import "OneTimerVC.h"
#import "ManyTimerVC.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_table;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"毫秒倒计时列表实现";
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row == 0 ? @"一个定时器实现列表倒计时" : @"N个定时器实现列表倒计时";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 使用毫秒倒计时时，个人建议用一个定时器来倒计时全局会比较理想，如果一个Cell弄一个timer会很耗资源。
    id VC;
    if (indexPath.row == 0) {
        VC = [[OneTimerVC alloc] init];
    } else {
        VC = [[ManyTimerVC alloc] init];
    }
    [self.navigationController pushViewController:VC animated:YES];
}

@end
