//
//  NianTableViewCell.h
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NianFrameModel.h"

@interface NianTableViewCell : UITableViewCell

@property (nonatomic, strong) NianModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
