//
//  UIView+EBBadgeHelper.m
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/4.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "UIView+EBBadgeHelper.h"
#import <objc/runtime.h>
#import "EBBadgeModel.h"

static char kAssociatedBadgeHelperKey;
static char kAssociatedBadgeModelChangeBlockKey;

@implementation UIView (EBBadgeHelper)
@dynamic eb_badgeModel;//告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成
@dynamic eb_badgeModelChangeBlock;

- (void)setEb_badgeModel:(EBBadgeModel *)eb_badgeModel{
    objc_setAssociatedObject(self,&kAssociatedBadgeHelperKey,eb_badgeModel,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (EBBadgeModel *)eb_badgeModel{
    return objc_getAssociatedObject(self,&kAssociatedBadgeHelperKey);
}

- (void)setEb_badgeModelChangeBlock:(BadgeModelChangeBlock)eb_badgeModelChangeBlock{
    objc_setAssociatedObject(self,&kAssociatedBadgeModelChangeBlockKey,eb_badgeModelChangeBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BadgeModelChangeBlock)eb_badgeModelChangeBlock{
    return objc_getAssociatedObject(self,&kAssociatedBadgeModelChangeBlockKey);
}

- (void)eb_updateSuperViewBadgeModel{
    if (self.eb_badgeModelChangeBlock) {
        self.eb_badgeModelChangeBlock(self);
    }
    UIView *superView = [self superview];
    if (superView) {
        [superView eb_updateSuperViewBadgeModel];
    }
}

//获取所有subview的EBBadgeModel组成一个新的EBBadgeModel
- (void)eb_getSubViewsBadgeModelWithBlock:(void(^)(EBBadgeModel *badgeModel))block{
    [self eb_getSubviewsBadgeModelListWithBlock:^(NSArray<EBBadgeModel *> *badgeModelList) {
        block([UIView eb_badgeModelWithBadgeModelList:badgeModelList]);
    }];
}

//获取所有subview的EBBadgeModel
- (void)eb_getSubviewsBadgeModelListWithBlock:(void(^)(NSArray<EBBadgeModel*>* badgeModelList))block{
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSMutableArray <EBBadgeModel*>* badgeModelList = [NSMutableArray array];
        [self eb_findAllSubviewWithView:self badgeModelList:badgeModelList];
        block(badgeModelList);
    });
}

- (void)eb_findAllSubviewWithView:(UIView*)view badgeModelList:(NSMutableArray<EBBadgeModel*>*)badgeModelList{
    for(UIView *subview in view.subviews){
        if (subview.eb_badgeModel) {
            [badgeModelList addObject:subview.eb_badgeModel];
        }else {
            if (subview.subviews.count>0) {
                [self eb_findAllSubviewWithView:subview badgeModelList:badgeModelList];
            }
        }
    }
}

+ (EBBadgeModel*)eb_badgeModelWithBadgeModelList:(NSArray<EBBadgeModel*> *)badgeModelList{
    if (badgeModelList.count==0) {
        return nil;
    }else if (badgeModelList.count==1) {
        return [badgeModelList firstObject];
    }else {
        NSInteger totleNumber = 0;
        
        for(NSInteger index = 0; index < badgeModelList.count; index++){
            EBBadgeModel *badgeModel = [badgeModelList objectAtIndex:index];
            if (badgeModel.badgeViewType == EBBadgeViewTypeNumber) {
                totleNumber += badgeModel.badgeNumber;
            }
        }
        
        if (totleNumber != 0) {
            //有数字类型，显示数字
            EBBadgeModel *retModel = [[EBBadgeModel alloc] init];
            retModel.badgeViewType = EBBadgeViewTypeNumber;
            retModel.badgeNumber = totleNumber;
            return retModel;
        }else {
            //其他类型
            EBBadgeModel *retModel = [[EBBadgeModel alloc] init];
            retModel.badgeViewType = EBBadgeViewTypePoint;
            return retModel;
        }
    }
}
@end