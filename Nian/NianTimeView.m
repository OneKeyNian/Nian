//
//  NianTimeView.m
//  Nian
//
//  Created by 周宏 on 15/7/8.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianTimeView.h"

@interface NianTimeView ()

@property (nonatomic, weak)     UILabel *timeLabel;

@property (nonatomic, strong)   NSTimer *timer;

@property (nonatomic, strong)   NSDateFormatter *formatter;

@end

@implementation NianTimeView

+ (instancetype)timeViewWithFrame:(CGRect)frame{
    NianTimeView *timeView = [[NianTimeView alloc] initWithFrame:frame];
    return timeView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        self.timeLabel = label;
        [self addSubview:label];
        label.frame = self.bounds;
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        self.timer  = timer;
        [timer fire];
    }
    return self;
}

- (void)updateTime{
    NSDate *date = [NSDate date];
    self.timeLabel.text = [self.formatter stringFromDate:date];
}

- (NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"MMdd hh:mm ss\"";
    }
    return _formatter;
}

- (void)invalidate{
    [self.timer invalidate];
}

@end
