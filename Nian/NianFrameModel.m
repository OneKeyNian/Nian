//
//  NianFrameModel.m
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianFrameModel.h"
#define SIZE(str, font) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : font} context:nil].size

@implementation NianFrameModel

- (void)setModel:(NianModel *)model{
    _model = model;
    
    CGSize  sScreen     = [UIScreen mainScreen].bounds.size;
    
    CGFloat rPoint      = 8;
    CGFloat xPoint      = sScreen.width * 0.5 - rPoint * 0.5;
    CGFloat yPoint      = 20;
    _fPoint = CGRectMake(xPoint, yPoint, rPoint, rPoint);
    
    CGFloat hContent    = 50;
    CGFloat wContent    = sScreen.width * 0.5 - 40;
    CGFloat yContent    = 0;
    CGFloat xContent    = 20;
    
    CGFloat hTime       = hContent;
    CGFloat wTime       = wContent;
    CGFloat yTime       = 0;
    CGFloat xTime       = sScreen.width * 0.5 + 20;
    
    if (model.index%2 == 1) {
        xContent        = xTime;
        xTime           = 20;
    }
    
    _fContent = CGRectMake(xContent, yContent, wContent, hContent);
    _fTime    = CGRectMake(xTime, yTime, wTime, hTime);
    
#warning img
    
    _cellHeight = CGRectGetMaxY(_fContent) > 65 ? CGRectGetMaxY(_fContent) : 65;
}

@end
