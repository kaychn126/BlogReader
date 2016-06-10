//
//  EBBadgeModel.m
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/6.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "EBBadgeModel.h"

@implementation EBBadgeModel
+ (EBBadgeModel*)badgeModelWithType:(EBBadgeViewType)badgeType{
    EBBadgeModel *badgeModel = [[EBBadgeModel alloc] init];
    badgeModel.badgeViewType = badgeType;
    return badgeModel;
}
@end
