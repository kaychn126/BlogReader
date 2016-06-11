//
//  EBBadgeModel.h
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/6.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  BadgeViewType
 */
typedef NS_ENUM(NSInteger, EBBadgeViewType) {
    /**
     *  Numeric Type
     */
    EBBadgeViewTypeNumber=0,
    /**
     *  Point Type
     */
    EBBadgeViewTypePoint=1,
    /**
     *  String Type
     */
    EBBadgeViewTypeString=2
};

@interface EBBadgeModel : NSObject


+ (EBBadgeModel*)badgeModelWithType:(EBBadgeViewType)badgeType;

/**
 badge content, must not nil when badgeViewType is EBBadgeViewTypeString
 */
@property(nonatomic, strong)NSString *badgeValue;

/**
 badge number, must not nil when badgeViewType is EBBadgeViewTypeNumber
 */
@property(nonatomic, assign)NSInteger badgeNumber;


@property(nonatomic, assign)EBBadgeViewType badgeViewType;
@end
