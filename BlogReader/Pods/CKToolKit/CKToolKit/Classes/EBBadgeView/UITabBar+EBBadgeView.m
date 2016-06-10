//
//  UITabBar+EBBadgeView.m
//  BadgeSimple
//
//  Created by EasyBenefit on 16/5/7.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "UITabBar+EBBadgeView.h"
#import <objc/runtime.h>
#import "EBBadgeModel.h"
#import "UIView+EBBadgeView.h"

#define kDefaultBadgeViewOffset CGPointMake(14, 14)
static char kAssociatedTabBarBadgeKey;

static NSString *kTabBarItemBadgeOffsetKey = @"eb_badgeOffset";

@implementation UITabBar (EBBadgeView)

- (void)setEb_tabBarItemList:(NSMutableArray<UIView *> *)eb_tabBarItemList{
    if (eb_tabBarItemList != self.eb_tabBarItemList) {
        if (self.eb_tabBarItemList) {
            [self.eb_tabBarItemList makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        for (UIView *view in eb_tabBarItemList) {
            [self addSubview:view];
        }
        objc_setAssociatedObject(self,&kAssociatedTabBarBadgeKey,eb_tabBarItemList,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSMutableArray<UIView *> *)eb_tabBarItemList{
    return objc_getAssociatedObject(self, &kAssociatedTabBarBadgeKey);
}

- (void)eb_showWithBadgeModel:(EBBadgeModel*)badgeModel atIndex:(NSInteger)index{
    if (index > self.items.count-1) {
        return;
    }
    
    if (!self.eb_tabBarItemList) {
        [self eb_setupTabBarBadgeItems];
    }
    UIView *view = [self.eb_tabBarItemList objectAtIndex:index];
    [view eb_showWithBadgeModel:badgeModel];
}

- (void)eb_setItemBadgeOffset:(CGPoint)offset{
    if (!self.eb_tabBarItemList) {
        [self eb_setupTabBarBadgeItems];
    }
    [self setValue:[NSValue valueWithCGPoint:offset] forUndefinedKey:kTabBarItemBadgeOffsetKey];
    CGFloat itemWidth = self.bounds.size.width/self.items.count;
    for (NSInteger i = 0; i < self.items.count; i++){
        UIView *view = [self.eb_tabBarItemList objectAtIndex:i];
        CGFloat itemCenterX = itemWidth/2 + itemWidth*i;
        CGPoint badgeViewCenter = CGPointMake(itemCenterX+offset.x, self.bounds.size.height/2-offset.y);
        view.frame = CGRectMake(badgeViewCenter.x, badgeViewCenter.y, 1, 1);
    }
}

- (void)eb_setupTabBarBadgeItems{
    CGFloat itemWidth = self.bounds.size.width/self.items.count;
    
    NSMutableArray *itemList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.items.count; i++) {
        CGFloat itemCenterX = itemWidth/2 + itemWidth*i;
        CGPoint badgeOffset = [[self valueForUndefinedKey:kTabBarItemBadgeOffsetKey] CGPointValue];
        
        if (badgeOffset.x == 0 && badgeOffset.y == 0) {
            badgeOffset = kDefaultBadgeViewOffset;
            [self setValue:[NSValue valueWithCGPoint:badgeOffset] forUndefinedKey:kTabBarItemBadgeOffsetKey];
        }
        CGPoint badgeViewCenter = CGPointMake(itemCenterX+badgeOffset.x, self.bounds.size.height/2-badgeOffset.y);
        
        UIView *itemView = [[UIView alloc] init];
        itemView.backgroundColor = [UIColor clearColor];
        itemView.frame = CGRectMake(badgeViewCenter.x, badgeViewCenter.y, 1, 1);
        [itemList addObject:itemView];
    }
    self.eb_tabBarItemList = itemList;
}

-(id)valueForUndefinedKey:(NSString *)key{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_COPY);
}
@end
