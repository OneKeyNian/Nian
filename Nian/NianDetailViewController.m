//
//  NianDetailViewController.m
//  Nian
//
//  Created by 周宏 on 15/7/17.
//  Copyright (c) 2015年 周宏. All rights reserved.
//

#import "NianDetailViewController.h"
#import "NianCollectionViewCell.h"
#import "NianCollectionViewLayout.h"

@interface NianDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, NianCollectionViewCellDelegate>

@property (nonatomic, strong)   NianModel           *model;

@property (nonatomic, weak)     UICollectionView    *cv;

@property (nonatomic, strong)   NSArray             *dataSource;

/**
 *  点击的顺序 如果为-1 表示是首页的左侧视图
 */
@property (nonatomic, assign)   int                 index;

@end

@implementation NianDetailViewController

+ (instancetype)vcWitharray:(NSArray *)array index:(int)index{
    NianDetailViewController *vc = [[NianDetailViewController alloc] init];
    vc.index = index;
    vc.dataSource = array;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NianCollectionViewLayout *flowLayout = [[NianCollectionViewLayout alloc] init];
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout ];
    cv.showsHorizontalScrollIndicator   = NO;
    cv.showsVerticalScrollIndicator     = NO;
    cv.backgroundColor  = [UIColor whiteColor];
    cv.delegate         = self;
    cv.dataSource       = self;
    self.cv             = cv;
    [self.view addSubview:cv];
    [cv registerClass:[NianCollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    if (self.index != -1) {
        [cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    cv.pagingEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)collectionViewCelldoubleTap{
    if (self.index == -1) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    cell.delegate = self;
    
    return cell;
}

@end
