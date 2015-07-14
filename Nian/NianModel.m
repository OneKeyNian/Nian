//
//  NianModel.m
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianModel.h"

@implementation NianModel

- (void)setDate:(NSDate *)date{
    _date                       = date;
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat        = @"MM dd HH mm";
    _strDate                    = [formatter stringFromDate:date];
}

- (instancetype)initWithDate:(NSDate *)date text:(NSString *)text img:(UIImage *)img{
    self = [super init];
    if (self) {
        self.date = date;
        self.text = text;
        self.img  = img;
    }
    return self;
}

+ (instancetype)modelWithDate:(NSDate *)date text:(NSString *)text img:(UIImage *)img{
    return [[NianModel alloc] initWithDate:date text:text img:img];
}

@end
