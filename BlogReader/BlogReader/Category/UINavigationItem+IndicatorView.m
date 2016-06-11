//
//  UINavigationItem+IndicatorView.m
//  BlogReader
//
//  Created by EB on 16/6/11.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "UINavigationItem+IndicatorView.h"
#import "BRUtils.h"

@implementation UINavigationItem (IndicatorView)
- (void)showIndicatorViewWithStatus:(NSString*)status{
    [[EBNavigationItemIndicatorView sharedInstance] setStatus:status];
    self.titleView = [EBNavigationItemIndicatorView sharedInstance];
}

- (void)hideIndicatorView{
    [BRUtils executeMainQueue:^{
        [[EBNavigationItemIndicatorView sharedInstance].indicatorView stopAnimating];
        self.titleView = nil;
    } afterSeconds:0.5];
}
@end

@interface EBNavigationItemIndicatorView()
@property(nonatomic, strong)UILabel *label;
@end

@implementation EBNavigationItemIndicatorView

+ (EBNavigationItemIndicatorView *)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[self alloc] initSingleton];
    });
    return sharedInstance;
}

- (instancetype)initSingleton{
    if(self = [super init]){
        self.backgroundColor = [UIColor redColor];
        _label = [[UILabel alloc] init];
        _label.font = kBRFont(17);
        _label.textColor = kRGBColor(51, 51, 51);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
    }
    return self;
}

- (instancetype)init{
    return [self initSingleton];
}

- (void)setStatus:(NSString *)status{
    _status = status;
    if(_status.length>0){
        _label.text = _status;
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.centerX.mas_equalTo(self).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(70, 44));
        }];
        [_indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(_label.mas_left);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        [_indicatorView startAnimating];
    }else{
        //只显示_indicatorView
        _label.text = _status;
        [_indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        [_indicatorView startAnimating];
    }
}
@end