//
//  BRWebViewController.m
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRWebViewController.h"
#import "BRKeyValueStore.h"
#import "BRUtils.h"

@interface BRWebViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView *webView;
@end

@implementation BRWebViewController

#pragma mark- lifecycle
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if(_webUrl.length>0){
        NSString *md5Key = [BRUtils md5:_webUrl];
        [[BRKeyValueStore sharedInstance] putNumber:[NSNumber numberWithFloat:self.webView.scrollView.contentOffset.y] withId:md5Key];
        self.webView = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *md5Key = [BRUtils md5:_webUrl];
    NSNumber *contentOffsetNumber = [[BRKeyValueStore sharedInstance] getNumberById:md5Key];
    if(contentOffsetNumber){
        [self.webView.scrollView setContentOffset:CGPointMake(0, contentOffsetNumber.floatValue)];
    }
    [UIView animateWithDuration:0.15f animations:^{
        self.webView.alpha = 1;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- getter
- (UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        if (_webUrl) {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30]];
        }
    }
    return _webView;
}

#pragma mark- webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //获取title
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
