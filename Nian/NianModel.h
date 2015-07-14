//
//  NianModel.h
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NianModel : NSObject

@property (nonatomic, copy)             NSString    *text;

@property (nonatomic, strong)           UIImage     *img;

@property (nonatomic, copy)             NSDate      *date;

@property (nonatomic, assign)           int         index;

@property (nonatomic, copy, readonly)   NSString    *strDate;

+ (instancetype)modelWithDate:(NSDate *)date text:(NSString *)text img:(UIImage *)img;

- (instancetype)initWithDate:(NSDate *)date text:(NSString *)text img:(UIImage *)img;

@end
