//
//  NianCollectionViewCell.h
//  Nian
//
//  Created by 周宏 on 15/7/21.
//  Copyright (c) 2015年 周宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NianModel.h"

@class NianCollectionViewCell;

@protocol NianCollectionViewCellDelegate <NSObject>

- (void)collectionViewCelldoubleTap;

@end

@interface NianCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)   NianModel   *model;

@property (nonatomic, weak)     id<NianCollectionViewCellDelegate>  delegate;

@end
