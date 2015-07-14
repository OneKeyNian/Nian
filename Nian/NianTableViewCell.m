//
//  NianTableViewCell.m
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianTableViewCell.h"

@interface NianTableViewCell ()

@property (nonatomic, strong)   NianFrameModel  *fModel;

@property (nonatomic, weak)     UIView          *vPoint;
@property (nonatomic, weak)     UILabel         *labelTime;

@property (nonatomic, weak)     UILabel         *labelContent;
@property (nonatomic, weak)     UIImageView     *iv;

@end

@implementation NianTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID     = @"Nian";
    NianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[NianTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Nian"];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        
        UIView *vPoint          = [[UIView alloc] init];
        vPoint.backgroundColor  = [UIColor grayColor];
        vPoint.layer.masksToBounds = YES;
        self.vPoint             = vPoint;
        [self addSubview:vPoint];
        
        UILabel *labelTime   = [[UILabel alloc] init];
        labelTime.font       = [UIFont systemFontOfSize:13];
        self.labelTime       = labelTime;
        [self addSubview:labelTime];
        
        UILabel *labelContent   = [[UILabel alloc] init];
        labelContent.numberOfLines = 2;
        labelContent.font       = [UIFont systemFontOfSize:13];
        self.labelContent       = labelContent;
        [self addSubview:labelContent];
        
        UIImageView *iv         = [[UIImageView alloc] init];
        self.iv                 = iv;
        [self addSubview:iv];
    }
    return self;
}

- (void)setModel:(NianModel *)model{
    _model                      = model;
    NianFrameModel *fModel      = [[NianFrameModel alloc] init];
    fModel.model                = model;
    self.fModel                 = fModel;
    self.labelContent.text      = model.text;
    self.labelTime.text         = model.strDate;
    self.iv.image               = model.img;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.vPoint.frame           = self.fModel.fPoint;
    self.vPoint.layer.cornerRadius = self.vPoint.frame.size.width * 0.5;
    self.labelTime.frame        = self.fModel.fTime;
    self.labelContent.frame     = self.fModel.fContent;
    self.iv.frame               = self.fModel.fImg;
}

@end
