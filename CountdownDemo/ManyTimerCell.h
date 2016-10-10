//
//  ManyTimerCell.h
//  CountdownDemo
//
//  Created by chaolong on 16/10/10.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManyTimerCell : UITableViewCell

@property (nonatomic, strong) UILabel *countdown;
@property (nonatomic, assign) NSInteger remainTime;

- (void)setCellWithData:(NSInteger)remainTime;

@end
