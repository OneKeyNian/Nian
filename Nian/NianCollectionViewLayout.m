//
//  NianCollectionViewLayout.m
//  Nian
//
//  Created by 周宏 on 15/7/22.
//  Copyright (c) 2015年 周宏. All rights reserved.
//

#import "NianCollectionViewLayout.h"

@implementation NianCollectionViewLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.itemSize = [UIScreen mainScreen].bounds.size;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    CGFloat offsetAdjustment = MAXFLOAT;
//    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
//    
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
//    
//    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
//        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
//        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
//            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
//        }
//    }
//    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//}

@end
