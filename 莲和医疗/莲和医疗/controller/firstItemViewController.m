//
//  firstItemViewController.m
//  UFanDrawer
//
//  Created by zxt on 15/8/22.
//  Copyright (c) 2015年 zxt. All rights reserved.
//

#import "firstItemViewController.h"
#import "UIViewController+UFanViewController.h"
#import "CMCustomViews.h"
#import "CMImageUtils.h"
#import "userLoginView.h"

#define UFSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define UFSCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
@implementation firstItemViewController
{
    UIButton *orderBt;
    UIButton *zixunBt;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:.99];

    
    //loading 动画
    float topY = 180;
    if ([UIScreen mainScreen].bounds.size.height > 480.0) {
        topY += 40;
    }
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(UFSCREEN_WIDTH/2.5, topY, 80, 70)];
    loadingView.hidden = YES;
    [self.view addSubview:loadingView];
    
    hasLogin = NO;
   
    
    _html5WebView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotif:) name:@"hasLoginState" object:nil];
    
    
    
    orderBt = [[UIButton alloc]initWithFrame:CGRectMakeWithAutoSize(0, 623, 187.5, 44)];
    [orderBt setTitle:@"预约购买" forState:UIControlStateNormal];
    [orderBt setTitleColor:[UIColor colorWithMyNeed:74 green:108 blue:204 alpha:1] forState:UIControlStateNormal];
    orderBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17];
    orderBt.backgroundColor = [UIColor colorWithMyNeed:242 green:240 blue:254 alpha:1];
    [orderBt addTarget:self action:@selector(orderBtClick) forControlEvents:UIControlEventTouchUpInside];
    orderBt.hidden = YES;
    [self.view addSubview:orderBt];
    
    zixunBt = [[UIButton alloc] initWithFrame:CGRectMakeWithAutoSize(187.5, 623, 187.5, 44)];
    [zixunBt setTitle:@"在线咨询" forState:UIControlStateNormal];
    zixunBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17];
    zixunBt.backgroundColor = [UIColor colorWithMyNeed:242 green:240 blue:254 alpha:1];
    [zixunBt setTitleColor:[UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1] forState:UIControlStateNormal];
    [zixunBt addTarget:self action:@selector(zixunBtClick) forControlEvents:UIControlEventTouchUpInside];
    zixunBt.hidden = YES;
    [self.view addSubview:zixunBt];
    

}

- (void)orderBtClick
{
//    [jsBridge callHandler:@"showHtmlcallJava" data:nil responseCallback:^(id responseData)
//     {
//         NSLog(@"%@",responseData);
//     }];
    
    NSString *js = [NSString stringWithFormat:@"showHtmlcall();"];
    NSString *str = [self.html5WebView stringByEvaluatingJavaScriptFromString:js];
    NSArray *array = [str componentsSeparatedByString:@","];
    orderViewController *ovc = [[orderViewController alloc] init];
    ovc.productId = [array[0] integerValue];
    ovc.productName = array[1];
    ovc.price = array[2];
    [self.navigationController pushViewController:ovc animated:YES];
}

- (void)zixunBtClick
{
    NSString *zXurl = [NSString stringWithFormat:ZXZX_PAGE];
    [self.html5WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:zXurl]]];
    orderBt.hidden = zixunBt.hidden = YES;
}

- (void)setLeftBarButtonItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" 返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
         self.navigationItem.leftBarButtonItem = item;
    
    
  
}

- (void)leftAction{
    
    
        if ([_html5WebView canGoBack])
             {
                 [_html5WebView goBack];
             }

    }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    lastUserPhone = getStringForKey(@"userPhoneNo");
    lastToken = getStringForKey(@"token");
    if (lastToken !=nil & lastUserPhone !=nil)
    {
        hasLogin = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if(hasLogin & ![_strURL.absoluteString isEqual:ZXZX_PAGE])
    {
        NSString *str = [NSString stringWithFormat:@"%@?token=%@",_strURL.absoluteString,lastToken];
        NSURL *str_URL_withToken = [[NSURL alloc] initWithString:str];
        _strURL = str_URL_withToken;
    }
    
    NSLog(@"WebViewController URL: %@", _strURL);
    _html5WebView.scalesPageToFit = YES;
    [_html5WebView loadRequest:[NSURLRequest requestWithURL:_strURL]];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSURL *currentUrl = [request URL];
//    NSURL *url = [[NSURL alloc] initWithString:WDJC_PAGE];
    NSString *prodct = [NSString stringWithFormat:@"http://mapi.lhgene.cn/m/product"];
    
    NSString *title =[_html5WebView stringByEvaluatingJavaScriptFromString:@"document.title"];  //获取链接标题
    if(title.length>12)
    {
        title = [[title substringWithRange:NSMakeRange(0, 11)] stringByAppendingString:@"..."];
    }
    
//    if ([currentUrl isEqual:url])
//    {
//        userLoginView *ulv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
//        UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:ulv];
//        ulv.navigationController.navigationBar.hidden = YES;
//        [self presentViewController:unc animated:YES completion:nil];
//    }
    
    if ([currentUrl.absoluteString containsString:prodct])
    {
        orderBt.hidden = NO;
        zixunBt.hidden = NO;
        title = @"产品介绍";
    }
    
    self.navigationItem.title = title;
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    if([_html5WebView canGoBack])
    {
        [self setLeftBarButtonItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }

    loadingView.hidden = NO;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    loadingView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    loadingView.hidden = YES;
}



-(void)receivedNotif:(NSNotification *)notification {
    hasLogin = YES;
}

@end


