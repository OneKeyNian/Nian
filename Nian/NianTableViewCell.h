//
//  NianTableViewCell.h
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NianFrameModel.h"

@class NianTableViewCell;

@protocol NianTableViewCellDelegate <NSObject>

- (void)doubleTapWithModel:(NianModel *)model;

@end

@interface NianTableViewCell : UITableViewCell

@property (nonatomic, strong) NianModel *model;

@property (nonatomic, weak) id<NianTableViewCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
