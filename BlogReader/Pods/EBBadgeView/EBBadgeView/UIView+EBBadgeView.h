//
//  UIView+EBBadgeView.h
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/6.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+EBBadgeHelper.h"

@class EBBadgeModel;
@interface UIView (EBBadgeView)
@property(nonatomic, strong)UIImageView *eb_badgeValueView;//number or string in view
@property(nonatomic, strong)UIImageView *eb_badgePointView;//point view
@property(nonatomic, strong)UILabel *eb_badgeLabel;

- (void)eb_showWithBadgeModel:(EBBadgeModel*)badgeModel;

- (void)eb_observeBadgeChange;
@end
