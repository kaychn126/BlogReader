//
//  UITabBar+EBBadgeView.h
//  BadgeSimple
//
//  Created by EasyBenefit on 16/5/7.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBBadgeModel;
@interface UITabBar (EBBadgeView)
@property(nonatomic, strong)NSMutableArray<UIView *> *eb_tabBarItemList;

- (void)eb_showWithBadgeModel:(EBBadgeModel*)badgeModel atIndex:(NSInteger)index;

- (void)eb_setItemBadgeOffset:(CGPoint)offset;
@end
