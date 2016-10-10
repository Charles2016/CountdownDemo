//
//  ManyTimerCell.m
//  CountdownDemo
//
//  Created by chaolong on 16/10/10.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "ManyTimerCell.h"

@interface ManyTimerCell () {
    NSTimer *_timer;
}
@end

@implementation ManyTimerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    _countdown = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 80)];
    _countdown.textColor = [UIColor redColor];
    [self addSubview:_countdown];
    
}

- (void)setCellWithData:(NSInteger)remainTime {
    _remainTime = remainTime;
    [self timerStart];
}

- (void)timerStop {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerStart {
    if (!_timer && _remainTime > 0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(countdownAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
}

- (void)countdownAction {
    if (_remainTime <= 0) {
        [self timerStop];
        _countdown.text = @"此Cell倒计时完成";
    } else {
        _remainTime -= 10;
        NSString *hour = [NSString stringWithFormat:@"%ld", _remainTime/1000/60/60];
        NSString *minute = [NSString stringWithFormat:@"%ld", _remainTime/1000/60%60];
        NSString *second = [NSString stringWithFormat:@"%ld", _remainTime/1000%60];
        CGFloat sss = _remainTime%1000/10;
        NSString *ss = [NSString stringWithFormat:@"%.lf", sss];
        if (hour.integerValue && hour.integerValue < 10) {
            hour = [NSString stringWithFormat:@"0%@", hour];
        }
        if (minute.integerValue < 10) {
            minute = [NSString stringWithFormat:@"0%@", minute];
        }
        if (second.integerValue < 10) {
            second = [NSString stringWithFormat:@"0%@", second];
        }
        if (ss.integerValue < 10) {
            ss = [NSString stringWithFormat:@"0%@", ss];
        }
        _countdown.font = [UIFont systemFontOfSize:28];
        if (hour.integerValue) {
            _countdown.text = [NSString stringWithFormat:@"%@:%@:%@:%@", hour, minute, second, ss];
        } else {
            _countdown.text = [NSString stringWithFormat:@"%@:%@:%@", minute, second, ss];
        }
    }
}
@end
