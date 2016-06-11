//
//  UINavigationItem+IndicatorView.h
//  BlogReader
//
//  Created by EB on 16/6/11.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (IndicatorView)
- (void)showIndicatorViewWithStatus:(NSString*)status;
- (void)hideIndicatorView;
@end

@interface EBNavigationItemIndicatorView : UIView
+ (EBNavigationItemIndicatorView *)sharedInstance;
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;
@end