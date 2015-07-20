//
//  NianFrameModel.m
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianFrameModel.h"
#define Size(str, font) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : font} context:nil].size
#define SizeWithMaxFloat(str, font, maxFloat) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, maxFloat) options:0 attributes:@{NSFontAttributeName : font} context:nil].size
#define FontSize 14
#define margin   20
#define Font     [UIFont systemFontOfSize:FontSize]

@implementation NianFrameModel

- (void)setModel:(NianModel *)model{
    _model = model;
    
    CGSize  sScreen     = [UIScreen mainScreen].bounds.size;
    
    CGFloat rPoint      = 8;
    CGFloat xPoint      = sScreen.width * 0.5 - rPoint * 0.5;
    CGFloat yPoint      = 20;
    _fPoint = CGRectMake(xPoint, yPoint, rPoint, rPoint);
    
    CGFloat maxFloat    = sScreen.width * 0.5 - margin * 2;
    
    CGFloat wContent    = SizeWithMaxFloat(model.text, Font, maxFloat).width;
    CGFloat hContent    = 50;
    CGFloat yContent    = 0;
    CGFloat xContent    = sScreen.width * 0.5 - margin - wContent;
    
    CGFloat hTime       = hContent;
    CGFloat wTime       = Size(model.strDate, Font).width;
    CGFloat yTime       = 0;
    CGFloat xTime       = sScreen.width * 0.5 + margin;
    
    if (model.index % 2 == 0) {
        xContent    = xTime;
        xTime       = sScreen.width * 0.5 - margin - wTime;
    }
    
    _fContent = CGRectMake(xContent, yContent, wContent, hContent);
    _fTime    = CGRectMake(xTime, yTime, wTime, hTime);
    
#warning img
    
    _cellHeight = CGRectGetMaxY(_fContent) > 65 ? CGRectGetMaxY(_fContent) : 65;
}

@end