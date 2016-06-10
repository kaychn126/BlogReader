//
//  UIScrollView+EBEmptyView.m
//  BadgeProject
//
//  Created by EasyBenefit on 16/5/6.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "UIScrollView+EBEmptyView.h"
#import <objc/runtime.h>

#define kEmptyImageWidth 150
#define kEmptyImageHeight 150

static char kAssociatedEmptyViewKey;

@implementation UIScrollView (EBEmptyView)
@dynamic eb_emptyView;

- (void)setEb_emptyView:(EBEmptyView *)eb_emptyView{
    if (eb_emptyView != self.eb_emptyView) {
        [self.eb_emptyView removeFromSuperview];
        if (eb_emptyView) {
            [self addSubview:eb_emptyView];
        }
        objc_setAssociatedObject(self, &kAssociatedEmptyViewKey, eb_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (EBEmptyView*)eb_emptyView{
    return objc_getAssociatedObject(self, &kAssociatedEmptyViewKey);
}

//显示默认空白页
- (void)eb_showDefaultEmptyView:(BOOL)show{
    [self eb_showEmptyView:show withEmptyImage:@"emptyImage" withEmptyText:nil];
}

- (void)eb_showEmptyView:(BOOL)show withEmptyImage:(NSString *)emptyImage withEmptyText:(NSString*)emptyText{
    if (show) {
        EBEmptyView *emptyView = [[EBEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
        [emptyView.emptyImageView setImage:[UIImage imageNamed:emptyImage]];
        emptyView.emptyLabel.text = emptyText;
        [self setEb_emptyView:emptyView];
    }else {
        [self setEb_emptyView:nil];
    }
}
@end

@implementation EBEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _emptyImageView = [[UIImageView alloc] init];
        _emptyImageView.frame = CGRectMake((frame.size.width-kEmptyImageWidth)/2, (frame.size.height-kEmptyImageHeight)/2, kEmptyImageWidth, kEmptyImageHeight);
        _emptyImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_emptyImageView];
        
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.font = [UIFont systemFontOfSize:16];
        _emptyLabel.textColor = [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1];
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.frame = CGRectMake(30, _emptyImageView.frame.origin.y+_emptyImageView.frame.size.height, frame.size.width-60, 36);
        [self addSubview:_emptyLabel];
    }
    return self;
}

@end