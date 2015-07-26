//
//  NianCollectionViewCell.m
//  Nian
//
//  Created by 周宏 on 15/7/21.
//  Copyright (c) 2015年 周宏. All rights reserved.
//

#import "NianCollectionViewCell.h"
#import "UIView+ZH.h"

#define Size(str, font) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : font} context:nil].size
#define SizeWithMaxFloat(str, font, maxFloat) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, maxFloat) options:0 attributes:@{NSFontAttributeName : font} context:nil].size
#define Magin 30
#define MaginTime 5

@interface NianCollectionViewCell ()

@property (nonatomic, weak)     UIImageView *iv;

@property (nonatomic, weak)     UILabel     *labelDay;
@property (nonatomic, weak)     UILabel     *labelSecond;
@property (nonatomic, weak)     UILabel     *labelYear;

@property (nonatomic, weak)     UILabel     *labelText;

@property (nonatomic, strong)   UITapGestureRecognizer *tap;

@end

@implementation NianCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addTapGestureRecognizer];
        [self setupSubviews];
    }
    return self;
}

- (void)setModel:(NianModel *)model{
    _model = model;
    NSDate *date = model.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"MMdd";
    self.labelDay.text = [formatter stringFromDate:date];
    self.labelDay.size = Size(self.labelDay.text, [UIFont systemFontOfSize:40]);
    
    formatter.dateFormat = @"yyyy";
    self.labelYear.text = [formatter stringFromDate:date];
    self.labelYear.size = Size(self.labelYear.text, [UIFont systemFontOfSize:18]);
    
    formatter.dateFormat = @"HH:mm''ss";
    self.labelSecond.text = [formatter stringFromDate:date];
    self.labelSecond.size = Size(self.labelSecond.text, [UIFont systemFontOfSize:18]);
    
    self.labelText.text = model.text;
    self.labelText.size = SizeWithMaxFloat(model.text, [UIFont systemFontOfSize:20], self.width - 2 * Magin);
    
    if (model.img) {
        self.iv.image = model.img;
        
    } else {
        self.labelDay.origin = CGPointMake(Magin, 200);
        self.labelYear.origin = CGPointMake(Magin + self.labelDay.width + MaginTime, 200);
        self.labelSecond.origin = CGPointMake(Magin + self.labelDay.width + MaginTime, CGRectGetMaxY(self.labelYear.frame));
        self.labelText.origin = CGPointMake(Magin, CGRectGetMaxY(self.labelYear.frame) + 30);
    }
}

- (void)addTapGestureRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    self.tap = tap;
    tap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap];
}

- (void)doubleTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(collectionViewCelldoubleTap)]) {
        [self.delegate collectionViewCelldoubleTap];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setupSubviews{
    UIImageView *iv = [[UIImageView alloc] init];
    self.iv         = iv;
    [self addSubview:iv];
    
    UILabel *labelDay = [[UILabel alloc] init];
    labelDay.font = [UIFont systemFontOfSize:40];
    self.labelDay = labelDay;
    [self addSubview:labelDay];
    
    UILabel *labelSecond = [[UILabel alloc] init];
    labelSecond.font = [UIFont systemFontOfSize:18];
    self.labelSecond = labelSecond;
    [self addSubview:labelSecond];
    
    UILabel *labelYear = [[UILabel alloc] init];
    labelYear.font = [UIFont systemFontOfSize:18];
    self.labelYear = labelYear;
    [self addSubview:labelYear];
    
    UILabel *labelText = [[UILabel alloc] init];
    labelText.font = [UIFont systemFontOfSize:20];
    self.labelText = labelText;
    [self addSubview:labelText];
}

@end
