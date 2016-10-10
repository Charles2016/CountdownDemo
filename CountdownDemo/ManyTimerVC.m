//
//  ManyTimerVC.m
//  CountdownDemo
//
//  Created by chaolong on 16/10/10.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "ManyTimerVC.h"
#import "ManyTimerCell.h"

@interface ManyTimerVC ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_countdowntable;
    NSTimer *_timer;
    CGFloat _passTime;
    NSMutableArray *_dataArray;
}

@end

@implementation ManyTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"N个定时器实现列表倒计时";
    _countdowntable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _countdowntable.delegate = self;
    _countdowntable.dataSource = self;
    [self.view addSubview:_countdowntable];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 20; i++) {
        // 取秒为单位
        [_dataArray addObject:@(rand()%600*1000)];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    ManyTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ManyTimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setCellWithData:[_dataArray[indexPath.row] integerValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
