//
//  NianTextField.h
//  Nian
//
//  Created by 周宏 on 15/7/9.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NianTextField;

@protocol NianTextFieldDelegate <NSObject>

- (void)showPhotoPicker;

- (void)done:(UITextField *)textField;

@end

@interface NianTextField : UIView

//+ (instancetype)textField;

@property (nonatomic, weak) id<NianTextFieldDelegate> delegate;

@end
