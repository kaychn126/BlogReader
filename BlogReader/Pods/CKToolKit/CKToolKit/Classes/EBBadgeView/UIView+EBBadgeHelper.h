//
//  UIView+EBBadgeHelper.h
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/4.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BadgeModelChangeBlock)(id sender);

@class EBBadgeModel;
@interface UIView (EBBadgeHelper)
@property(nonatomic, strong)EBBadgeModel *eb_badgeModel;
@property(nonatomic, copy)BadgeModelChangeBlock eb_badgeModelChangeBlock;

- (void)eb_updateSuperViewBadgeModel;

/**
 make all the subviews' BadgeModel into one BadgeModel
 
 @param block call back block
 */
- (void)eb_getSubViewsBadgeModelWithBlock:(void(^)(EBBadgeModel *badgeModel))block;

@end
