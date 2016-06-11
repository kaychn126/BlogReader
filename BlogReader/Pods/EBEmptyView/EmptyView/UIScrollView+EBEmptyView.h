//
//  UIScrollView+EBEmptyView.h
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/6.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EBEmptyView;
@interface UIScrollView (EBEmptyView)
@property(nonatomic, strong)EBEmptyView *eb_emptyView;

- (void)eb_showDefaultEmptyView:(BOOL)show;

- (void)eb_showEmptyView:(BOOL)show withEmptyImage:(NSString *)emptyImage withEmptyText:(NSString*)emptyText;
@end

@interface EBEmptyView : UIView
@property(nonatomic, strong)UIImageView *emptyImageView;
@property(nonatomic, strong)UILabel *emptyLabel;
@end