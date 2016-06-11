//
//  UIView+EBBadgeView.m
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/6.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "UIView+EBBadgeView.h"
#import "EBBadgeModel.h"
#import "UIView+EBBadgeHelper.h"
#import <objc/runtime.h>

static char kAssociatedBadgeValueViewKey;
static char kAssociatedBadgePointViewKey;
static char kAssociatedBadgeLabelKey;

#define kEBBadgeViewHeight 18

@implementation UIView (EBBadgeView)
@dynamic eb_badgeValueView,eb_badgePointView,eb_badgeLabel;

- (void)setEb_badgeValueView:(UIImageView *)eb_badgeValueView{
    if (self.eb_badgeValueView != eb_badgeValueView) {
        [self.eb_badgeValueView removeFromSuperview];
        if ([self isKindOfClass:UITableViewCell.class]) {
            UITableViewCell *cell = (UITableViewCell*)self;
            [cell.contentView addSubview:eb_badgeValueView];
            [cell.contentView bringSubviewToFront:eb_badgeValueView];
        }else{
            [self addSubview:eb_badgeValueView];
            [self bringSubviewToFront:eb_badgeValueView];
        }
        
        objc_setAssociatedObject(self, &kAssociatedBadgeValueViewKey, eb_badgeValueView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIImageView*)eb_badgeValueView{
    return objc_getAssociatedObject(self, &kAssociatedBadgeValueViewKey);
}

- (void)setEb_badgePointView:(UIImageView *)eb_badgePointView{
    if (self.eb_badgePointView != eb_badgePointView) {
        [self.eb_badgePointView removeFromSuperview];
        if ([self isKindOfClass:UITableViewCell.class]) {
            UITableViewCell *cell = (UITableViewCell*)self;
            [cell.contentView addSubview:eb_badgePointView];
            [cell.contentView bringSubviewToFront:eb_badgePointView];
        }else{
            [self addSubview:eb_badgePointView];
            [self bringSubviewToFront:eb_badgePointView];
        }
        
        objc_setAssociatedObject(self, &kAssociatedBadgePointViewKey, eb_badgePointView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIImageView*)eb_badgePointView{
    return objc_getAssociatedObject(self, &kAssociatedBadgePointViewKey);
}

- (void)setEb_badgeLabel:(UILabel *)eb_badgeLabel{
    objc_setAssociatedObject(self, &kAssociatedBadgeLabelKey, eb_badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel*)eb_badgeLabel{
    return objc_getAssociatedObject(self, &kAssociatedBadgeLabelKey);
}

- (void)eb_showWithBadgeModel:(EBBadgeModel*)badgeModel{
    if (self.eb_badgeModel == badgeModel) {
        return;
    }
    self.eb_badgeModel = badgeModel;
    if (self.superview) {
        [self.superview eb_updateSuperViewBadgeModel];
    }
    if (badgeModel) {
        if (badgeModel.badgeViewType == EBBadgeViewTypeNumber || badgeModel.badgeViewType == EBBadgeViewTypeString) {
            if ((badgeModel.badgeViewType == EBBadgeViewTypeNumber && badgeModel.badgeNumber<=0) || (badgeModel.badgeViewType == EBBadgeViewTypeString && badgeModel.badgeValue.length==0)) {
                [self eb_showWithBadgeModel:nil];
                return;
            }
            if (!self.eb_badgeValueView) {
                UIImage *badgeImage = [[UIImage imageNamed:@"badgePoint"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode: UIImageResizingModeStretch];
                UIImageView * badgeValueView = [[UIImageView alloc] initWithImage:badgeImage];
                UILabel *badgeValueLable = [[UILabel alloc] init];
                badgeValueLable.textAlignment = NSTextAlignmentCenter;
                badgeValueLable.font = [UIFont boldSystemFontOfSize:9];
                badgeValueLable.textColor = [UIColor whiteColor];
                [badgeValueView addSubview:badgeValueLable];
                
                self.eb_badgeLabel = badgeValueLable;
                self.eb_badgeValueView = badgeValueView;
            }
            if (badgeModel.badgeViewType == EBBadgeViewTypeNumber) {
                if (badgeModel.badgeNumber>99) {
                    self.eb_badgeLabel.text = @"99+";
                }else {
                    self.eb_badgeLabel.text = [NSString stringWithFormat:@"%ld",(long)badgeModel.badgeNumber];
                }
            }else {
                self.eb_badgeLabel.text = badgeModel.badgeValue;
            }
            
            [self.eb_badgeLabel sizeToFit];
            CGFloat badgeWidth =  MAX(self.eb_badgeLabel.bounds.size.width, self.eb_badgeLabel.bounds.size.height)+4;
            CGFloat badgeHeight = badgeWidth;
            if (self.eb_badgeLabel.text.length>1) {
                badgeWidth = self.eb_badgeLabel.bounds.size.width + 6;
                badgeHeight = self.eb_badgeLabel.bounds.size.height + 6;
            }
            
            badgeWidth = MAX(badgeWidth, kEBBadgeViewHeight);
            badgeHeight = MAX(badgeHeight, kEBBadgeViewHeight);
            
            self.eb_badgeValueView.frame = CGRectMake(0, 0, badgeWidth, badgeHeight);
            self.eb_badgeValueView.center = CGPointMake(self.bounds.size.width, 0);
            self.eb_badgeLabel.frame = self.eb_badgeValueView.bounds;
            self.eb_badgeValueView.hidden = NO;
            
            if (self.eb_badgePointView) {
                self.eb_badgePointView.hidden = YES;
            }
        }else if(badgeModel.badgeViewType == EBBadgeViewTypePoint){
            if (!self.eb_badgePointView) {
                UIImageView *badgePointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"badgePoint"]];
                badgePointView.frame = CGRectMake(0, 0, 12, 12);
                badgePointView.center = CGPointMake(self.bounds.size.width, 0);
                self.eb_badgePointView = badgePointView;
            }
            self.eb_badgePointView.hidden = NO;
            
            if (self.eb_badgeValueView) {
                self.eb_badgeValueView.hidden = YES;
            }
        }
    }else {
        if (self.eb_badgePointView) {
            self.eb_badgePointView.hidden = YES;
        }
        if (self.eb_badgeValueView) {
            self.eb_badgeValueView.hidden = YES;
        }
    }
}

- (void)eb_observeBadgeChange{
    __weak __typeof(&*self)weakSelf = self;
    
    [self eb_getSubViewsBadgeModelWithBlock:^(EBBadgeModel *badgeModel) {
        [weakSelf eb_showWithBadgeModel:badgeModel];
    }];
    
    self.eb_badgeModelChangeBlock = ^(id sender){
        [weakSelf eb_getSubViewsBadgeModelWithBlock:^(EBBadgeModel *badgeModel) {
            [weakSelf eb_showWithBadgeModel:badgeModel];
        }];
    };
}
@end
