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

#define GlobalHeight 44
#define LastDateKey  @"fejjiof"

@interface NianViewController () <UITableViewDataSource, UITableViewDelegate, NianTextFieldDelegate>

@property (nonatomic, weak)     UITableView     *tableView;

@property (nonatomic, strong)   NSMutableArray  *maryModel;

@property (nonatomic, strong)   NSMutableArray  *maryFrameModel;

@property (nonatomic, weak)     NianTimeView    *timeLabel;

@property (nonatomic, weak)     NianTextField   *textField;

// 半透明遮罩
@property (nonatomic, weak)     UIButton        *btnBg;

// 今天是否已经添加
@property (nonatomic, assign)   BOOL            flagToday;

// 当前是否已经显示了textfiled
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
    
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    NSNumber *old = [[NSUserDefaults standardUserDefaults] objectForKey:LastDateKey];
    if (old) {
        int i = ((int)([[NSDate date] timeIntervalSince1970] + timezoneFix) - (int)([old doubleValue] + timezoneFix))/(24 * 3600);
        if (i== 0) {
            self.flagToday = NO;
        }
    }
    
    
    // 建立数据库
    [NianDBTool createDB];
    
    [self setupSubviews];
    [self initialData];
    [self addNotif];
}

- (void)dealloc{
    [self.timeLabel invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidHideNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
}

- (void)addNotif{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)setupSubviews{
    // tableview
    UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, GlobalHeight, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.delegate      = self;
    tableView.dataSource    = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView          = tableView;
    [self.view addSubview:tableView];
    
    // 分隔线
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5 - 0.5, GlobalHeight, 0.5, self.view.bounds.size.height - 20)];
    vLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:vLine];
    
    // 时间label
    NianTimeView *timeLabel = [[NianTimeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, GlobalHeight)];
    self.timeLabel = timeLabel;
    [self.view addSubview:timeLabel];
    
    // 半透明遮罩
    UIButton *btnBg = [[UIButton alloc] initWithFrame:self.view.bounds];
    self.btnBg = btnBg;
    btnBg.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btnBg];
    btnBg.alpha = 0.0;
    btnBg.hidden = YES;
    [btnBg addTarget:self action:@selector(btnBgClick:) forControlEvents:UIControlEventTouchDown];
    
    // 输入框
    NianTextField *textField = [[NianTextField alloc] initWithFrame:CGRectMake(0, -44, self.view.bounds.size.width, GlobalHeight)];
    textField.delegate = self;
    self.textField = textField;
    [self.view addSubview:textField];
}

- (void)initialData{
    self.maryModel = [NianDBTool getLocalData];
}

#pragma mark - btnClick
- (void)btnBgClick:(UIButton *)btn{
    [self.textField endEditing:YES];
    self.flagTextFieldShow = NO;
}

#pragma mark - tableViewDelegate
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

#pragma mark - datasourceDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.flagToday) {
        return;
    }
    
    CGFloat y = scrollView.contentOffset.y;
    
    if (!self.flagTextFieldShow) {
        if (-GlobalHeight - y < 0) {
            self.textField.transform = CGAffineTransformMakeTranslation(0, -y);
        } else {
            self.textField.transform = CGAffineTransformMakeTranslation(0, GlobalHeight);
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.flagToday) {
        return;
    }
    
    if (self.textField.transform.ty == GlobalHeight) {
        self.flagTextFieldShow = YES;
        [self.textField becomeFirstResponder];
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

}

#pragma mark - NianTextFieldDelegate
- (void)done:(UITextField *)textField{
    self.flagTextFieldShow = NO;
    if (textField.text.length) {
        NianModel *model = [NianModel modelWithDate:[NSDate date] text:textField.text img:nil];
        [NianDBTool insertRecodeWithModel:model];
        [self.maryModel addObject:model];
        [self.tableView reloadData];
        textField.text = @"";
        [[NSUserDefaults standardUserDefaults] setObject:@([[NSDate date] timeIntervalSince1970]) forKey:LastDateKey];
        
        self.flagToday = YES;
    }
}

#pragma mark - keyboardObserver
- (void)keyboardWillHide:(NSNotification *)notification{
    NSString *duration  = (NSString *)notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSString *option    = (NSString *)notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    self.tableView.userInteractionEnabled = NO;
    [UIView animateKeyframesWithDuration:[duration floatValue] delay:0.0 options:[option intValue] animations:^{
        self.textField.transform = CGAffineTransformIdentity;
        self.btnBg.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.btnBg.hidden = YES;
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification{
    self.tableView.userInteractionEnabled = YES;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSString *duration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSString *option   = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    self.btnBg.hidden = NO;
    [UIView animateKeyframesWithDuration:[duration floatValue] delay:0.0 options:[option floatValue] animations:^{
        self.btnBg.alpha = 0.2;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardDidShow:(NSNotification *)notification{
    
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
