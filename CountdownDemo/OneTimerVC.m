//
//  OneTimerVC.m
//  CountdownDemo
//
//  Created by chaolong on 16/10/10.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "OneTimerVC.h"

@interface OneTimerVC ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_countdowntable;
    NSTimer *_timer;
    CGFloat _passTime;
    NSMutableArray *_dataArray;
}

@end

@implementation OneTimerVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"一个定时器实现列表倒计时";
    _countdowntable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _countdowntable.delegate = self;
    _countdowntable.dataSource = self;
    [self.view addSubview:_countdowntable];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 20; i++) {
        // 取秒为单位
        [_dataArray addObject:@(rand() % 600 * 1000)];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _passTime = 0.0f;
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerAction {
    //取出屏幕可见cell
    NSArray *cells = _countdowntable.visibleCells;
    _passTime += 10.f;
    
    for (UITableViewCell *cell in cells) {
        NSIndexPath *indexPath = [_countdowntable indexPathForCell:cell];
        NSInteger index = indexPath.row;
        NSInteger remainTime = [_dataArray[index] integerValue];
        if (remainTime - _passTime <= 0) {
            cell.textLabel.text = @"00:00:00";
            [_dataArray removeObjectAtIndex:index];
            [_countdowntable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else {
            NSString *minute = [NSString stringWithFormat:@"%d", (int)((remainTime - _passTime)/1000/60)%60];
            NSString *second = [NSString stringWithFormat:@"%d", ((int)(remainTime - _passTime))/1000%60];
            CGFloat sss = ((int)((remainTime - _passTime)))%1000/10;
            NSString *ss = [NSString stringWithFormat:@"%.lf", sss];
            if (minute.integerValue < 10) {
                minute = [NSString stringWithFormat:@"0%@", minute];
            }
            
            if (second.integerValue < 10) {
                second = [NSString stringWithFormat:@"0%@", second];
            }
            
            if (ss.integerValue < 10) {
                ss = [NSString stringWithFormat:@"0%@", ss];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@:%@:%@", minute, second, ss];
        }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
