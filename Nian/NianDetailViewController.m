//
//  NianDetailViewController.m
//  Nian
//
//  Created by 周宏 on 15/7/17.
//  Copyright (c) 2015年 周宏. All rights reserved.
//

#import "NianDetailViewController.h"
#import "UIView+ZH.h"

#define Size(str, font) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : font} context:nil].size
#define SizeWithMaxFloat(str, font, maxFloat) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, maxFloat) options:0 attributes:@{NSFontAttributeName : font} context:nil].size
#define Magin 30
#define MaginTime 5

@interface NianDetailViewController ()

@property (nonatomic, strong)   NianModel *model;


@property (nonatomic, weak)     UIImageView *iv;

@property (nonatomic, weak)     UILabel     *labelDay;
@property (nonatomic, weak)     UILabel     *labelSecond;
@property (nonatomic, weak)     UILabel     *labelYear;

@property (nonatomic, weak)     UILabel     *labelText;

@property (nonatomic, strong)   UITapGestureRecognizer *tap;

@end

@implementation NianDetailViewController

+ (instancetype)vcWithModel:(NianModel *)model{
    NianDetailViewController *vc = [[NianDetailViewController alloc] init];
    
    NSDate *date = model.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"MMdd";
    vc.labelDay.text = [formatter stringFromDate:date];
    vc.labelDay.size = Size(vc.labelDay.text, [UIFont systemFontOfSize:40]);
    
    formatter.dateFormat = @"yyyy";
    vc.labelYear.text = [formatter stringFromDate:date];
    vc.labelYear.size = Size(vc.labelYear.text, [UIFont systemFontOfSize:18]);
    
    formatter.dateFormat = @"HH:mm''ss";
    vc.labelSecond.text = [formatter stringFromDate:date];
    vc.labelSecond.size = Size(vc.labelSecond.text, [UIFont systemFontOfSize:18]);
    
    vc.labelText.text = model.text;
    vc.labelText.size = SizeWithMaxFloat(model.text, [UIFont systemFontOfSize:20], vc.view.width - 2 * Magin);
    
    if (model.img) {
        vc.iv.image = model.img;
        
    } else {
        vc.labelDay.origin = CGPointMake(Magin, 200);
        vc.labelYear.origin = CGPointMake(Magin + vc.labelDay.width + MaginTime, 200);
        vc.labelSecond.origin = CGPointMake(Magin + vc.labelDay.width + MaginTime, CGRectGetMaxY(vc.labelYear.frame));
        vc.labelText.origin = CGPointMake(Magin, CGRectGetMaxY(vc.labelYear.frame) + 30);
    }
    
    return vc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    self.tap = tap;
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
}

- (void)doubleTap:(UITapGestureRecognizer *)tap{
    NSLog(@"22");
}

//- (void)tap:(UITapGestureRecognizer *)tap{
//    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:0 animations:^{
//        self.view.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//    }];
//    
////    [UIView animateWithDuration:0.3 animations:^{
////        self.view.alpha = 0.0;
////    } completion:^(BOOL finished) {
////        [self.view removeFromSuperview];
////    }];
//}

- (void)setupSubviews{
    UIImageView *iv = [[UIImageView alloc] init];
    self.iv         = iv;
    [self.view addSubview:iv];
    
    UILabel *labelDay = [[UILabel alloc] init];
    labelDay.font = [UIFont systemFontOfSize:40];
    self.labelDay = labelDay;
    [self.view addSubview:labelDay];
    
    UILabel *labelSecond = [[UILabel alloc] init];
    labelSecond.font = [UIFont systemFontOfSize:18];
    self.labelSecond = labelSecond;
    [self.view addSubview:labelSecond];
    
    UILabel *labelYear = [[UILabel alloc] init];
    labelYear.font = [UIFont systemFontOfSize:18];
    self.labelYear = labelYear;
    [self.view addSubview:labelYear];
    
    UILabel *labelText = [[UILabel alloc] init];
    labelText.font = [UIFont systemFontOfSize:20];
    self.labelText = labelText;
    [self.view addSubview:labelText];
}

@end
