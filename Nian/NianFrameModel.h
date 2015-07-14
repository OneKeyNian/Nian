//
//  NianFrameModel.h
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NianModel.h"

@interface NianFrameModel : NSObject

@property (nonatomic, strong)            NianModel   *model;

@property (nonatomic, assign, readonly)  CGRect      fPoint;

@property (nonatomic, assign, readonly)  CGRect      fTime;

@property (nonatomic, assign, readonly)  CGRect      fContent;

@property (nonatomic, assign, readonly)  CGRect      fImg;

@property (nonatomic, assign, readonly)  CGFloat     cellHeight;

@end
