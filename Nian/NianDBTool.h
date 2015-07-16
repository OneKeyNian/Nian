//
//  NianDBTool.h
//  Nian
//
//  Created by 周宏 on 15/7/11.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NianModel.h"
@interface NianDBTool : NSObject

+ (NSMutableArray *)getLocalData;

+ (void)insertRecodeWithModel:(NianModel *)model;

+ (void)deleteTodayRecode;

+ (void)createDB;

@end
