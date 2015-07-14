//
//  NianTextField.m
//  Nian
//
//  Created by 周宏 on 15/7/9.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianTextField.h"

@interface NianTextField () <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIView      *vLine;

@end

@implementation NianTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UITextField *textField  = [[UITextField alloc] init];
        textField.placeholder   = @"输入文字";
        textField.returnKeyType = UIReturnKeyDone;
        textField.font          = [UIFont systemFontOfSize:13];
        textField.delegate      = self;
        self.textField          = textField;
        [self addSubview:textField];
        
        [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *vLine           = [[UIView alloc] init];
        vLine.backgroundColor   = [UIColor blackColor];
        self.vLine              = vLine;
        [self addSubview:vLine];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame    = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height);
    self.vLine.frame        = CGRectMake(0, 44 - 1, self.bounds.size.width, 0.5);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(done:)]) {
        [self.delegate done:self.textField];
    }
    return YES;
}

- (void)textFieldChange:(UITextField *)textField{
    NSLog(@"%@", textField.text);
}

- (BOOL)becomeFirstResponder{
    [super becomeFirstResponder];
    [self.textField becomeFirstResponder];
    return YES;
}

@end
