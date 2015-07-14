//
//  NianViewController.m
//  Nian
//
//  Created by 周宏 on 15/7/7.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianViewController.h"
#import "NianFrameModel.h"
#import "NianTableViewCell.h"
#import "NianTimeView.h"
#import "NianTextField.h"
#import "NianDBTool.h"

@interface NianViewController () <UITableViewDataSource, UITableViewDelegate, NianTextFieldDelegate>

@property (nonatomic, weak)     UITableView     *tableView;

@property (nonatomic, strong)   NSMutableArray  *maryModel;

@property (nonatomic, strong)   NSMutableArray  *maryFrameModel;

@property (nonatomic, weak)     NianTimeView    *timeLabel;

@property (nonatomic, weak)     NianTextField   *textField;

@property (nonatomic, assign)   BOOL            flagTextFieldShow;

@end

@implementation NianViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NianDBTool createDB];
    [self setupSubviews];
    [self initialData];
    [self addNotif];
}

- (void)dealloc{
    [self.timeLabel invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillChangeFrameNotification];
}

- (void)addNotif{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybodWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupSubviews{
    // tableview
    UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.delegate      = self;
    tableView.dataSource    = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView          = tableView;
    [self.view addSubview:tableView];
    
    // 分隔线
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5 - 0.5, 44, 0.5, self.view.bounds.size.height - 20)];
    vLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:vLine];
    
    // 时间label
    NianTimeView *timeLabel = [[NianTimeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.timeLabel = timeLabel;
    [self.view addSubview:timeLabel];
    
    // 输入框
    NianTextField *textField = [[NianTextField alloc] initWithFrame:CGRectMake(0, -44, self.view.bounds.size.width, 44)];
    textField.delegate = self;
    self.textField = textField;
    [self.view addSubview:textField];
}

- (void)initialData{
    self.maryModel = [NianDBTool getLocalData];
}

#pragma mark - tableViewDelegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.maryModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NianTableViewCell *cell = [NianTableViewCell cellWithTableView:tableView];
    
    NianModel *model = self.maryModel[indexPath.row];
    model.index = (int)indexPath.row;
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NianFrameModel *fModel = self.maryFrameModel[indexPath.row];
    return 65;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.flagTextFieldShow) {
        [self.textField endEditing:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (self.flagTextFieldShow == NO) {
        if (self.textField.frame.origin.y < 0) {
            if (-44 - y < 0) {
                self.textField.transform = CGAffineTransformMakeTranslation(0, -y);
            } else {
                self.textField.transform = CGAffineTransformMakeTranslation(0, 44);
                [self.textField becomeFirstResponder];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.flagTextFieldShow) {
        self.flagTextFieldShow = NO;
    } else{
        if (scrollView.contentOffset.y <= -44) {
            self.flagTextFieldShow = YES;
        }
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

}

#pragma mark - NianTextFieldDelegate
- (void)done:(UITextField *)textField{
    self.flagTextFieldShow = NO;
    
    [NianDBTool insertRecodeWithModel:[NianModel modelWithDate:[NSDate date] text:textField.text img:nil]];
}

#pragma mark - keyboardObserver
- (void)keybodWillHide:(NSNotification *)notifacation{
    NSLog(@"%@", notifacation.userInfo);
    NSString *dutation  = (NSString *)notifacation.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSString *option    = (NSString *)notifacation.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateKeyframesWithDuration:[dutation floatValue] delay:0.0 options:[option intValue] animations:^{
        self.textField.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        nil;
    }];
}

#pragma mark - getter & setter

- (NSMutableArray *)maryModel{
    if (!_maryModel) {
        _maryModel = [NSMutableArray array];
    }
    return _maryModel;
}

- (NSMutableArray *)maryFrameModel{
    if (!_maryFrameModel) {
        _maryFrameModel = [NSMutableArray array];
    }
    return _maryFrameModel;
}


@end
