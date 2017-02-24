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
    NSInteger ProNo;
    UIView *shareView;
    UIAlertController *aletCtrol;
    NSString *newsContains;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
  //  [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:.99];

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0,0,20,20);
    [shareButton addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
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
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotif:) name:@"hasLoginState" object:nil];
    
    if([_strURL.absoluteString containsString:[NSString stringWithFormat:@"http://mapi.lhgene.cn/m/product"]])
    {
        ProNo = [[_strURL.absoluteString stringByReplacingOccurrencesOfString:@"http://mapi.lhgene.cn/m/product/" withString:@""] integerValue];
        switch (ProNo) {
            case 1:
                [[Mixpanel sharedInstance] track:@"进入产品页" properties:@{@"product":@"和普安"}];
                break;
            case 2:
                [[Mixpanel sharedInstance] track:@"进入产品页" properties:@{@"product":@"和家安"}];
                break;
            case 3:
                [[Mixpanel sharedInstance] track:@"进入产品页" properties:@{@"product":@"和美安"}];
                break;
            default:
                break;
        }
        orderBt = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT  - 44, SCREEN_WEIGHT/2, 44)];
        [orderBt setTitle:@"预约取样" forState:UIControlStateNormal];
        [orderBt setTitleColor:[UIColor colorWithMyNeed:74 green:108 blue:204 alpha:1] forState:UIControlStateNormal];
        orderBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17];
        orderBt.backgroundColor = [UIColor colorWithMyNeed:242 green:240 blue:254 alpha:1];
        [orderBt addTarget:self action:@selector(orderBtClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:orderBt];
        
        zixunBt = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/2, SCREEN_HEIGHT - 44, SCREEN_WEIGHT/2, 44)];
        [zixunBt setTitle:@"在线咨询" forState:UIControlStateNormal];
        zixunBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17];
        zixunBt.backgroundColor = [UIColor colorWithMyNeed:242 green:240 blue:254 alpha:1];
        [zixunBt setTitleColor:[UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1] forState:UIControlStateNormal];
        [zixunBt addTarget:self action:@selector(zixunBtClick) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:zixunBt];
    }
    
    if([_strURL.absoluteString isEqualToString:@"http://mapi.lhgene.cn/m/faq"])
    {
        [[Mixpanel sharedInstance] track:@"首页点击FAQ"];
    }
    if([_strURL.absoluteString isEqualToString:ZXZX_PAGE])
    {
        [[Mixpanel sharedInstance] track:@"首页点击在线咨询"];
    }
    
    _html5WebView.scalesPageToFit = YES;
    [_html5WebView loadRequest:[NSURLRequest requestWithURL:_strURL]];
    
    shareView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,209)];//(0, SCREEN_HEIGHT, SCREEN_WEIGHT, 209*SCREEN_HEIGHT/667)];
    shareView.backgroundColor = [UIColor redColor];//[UIColor colorWithMyNeed:255 green:255 blue:255 alpha:0.77];
    //[self.view addSubview:shareView];


}

- (void)orderBtClick
{
    
    NSString *js = [NSString stringWithFormat:@"showHtmlcall();"];
    NSString *str = [self.html5WebView stringByEvaluatingJavaScriptFromString:js];
    NSArray *array = [str componentsSeparatedByString:@","];
    orderViewController *ovc = [[orderViewController alloc] init];
    if(![str isEqualToString:@""])
    {
        ovc.productId = [array[0] integerValue];
        ovc.productName = array[1];
        ovc.price = @"";
    }
    
    switch (ProNo) {
        case 1:
            [[Mixpanel sharedInstance] track:@"预约取样" properties:@{@"product":@"和普安"}];
            break;
        case 2:
            [[Mixpanel sharedInstance] track:@"预约取样" properties:@{@"product":@"和家安"}];
            break;
        case 3:
            [[Mixpanel sharedInstance] track:@"预约取样" properties:@{@"product":@"和美安"}];
            break;
        default:
            break;
    }

    
    
    [self.navigationController pushViewController:ovc animated:YES];
}

- (void)zixunBtClick
{
    NSString *zXurl = [NSString stringWithFormat:ZXZX_PAGE];
    [self.html5WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:zXurl]]];
    orderBt.hidden = zixunBt.hidden = YES;
    
    switch (ProNo) {
        case 1:
            [[Mixpanel sharedInstance] track:@"进入咨询页" properties:@{@"product":@"和普安"}];
            break;
        case 2:
            [[Mixpanel sharedInstance] track:@"进入咨询页" properties:@{@"product":@"和家安"}];
            break;
        case 3:
            [[Mixpanel sharedInstance] track:@"进入咨询页" properties:@{@"product":@"和美安"}];
            break;
        default:
            break;
    }

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

//    if(hasLogin & ![_strURL.absoluteString isEqual:ZXZX_PAGE])
//    {
//        NSString *str = [NSString stringWithFormat:@"%@?token=%@",_strURL.absoluteString,lastToken];
//        NSURL *str_URL_withToken = [[NSURL alloc] initWithString:str];
//        _strURL = str_URL_withToken;
//    }
    
    NSLog(@"WebViewController URL: %@", _strURL);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    loadingView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    
    NSString *title =[_html5WebView stringByEvaluatingJavaScriptFromString:@"document.title"];  //获取链接标题
    if(title.length>12)
    {
        title = [[title substringWithRange:NSMakeRange(0, 11)] stringByAppendingString:@"..."];
    }
    
    self.navigationItem.title = title;
    
    
    if([_html5WebView canGoBack])
    {
        [self setLeftBarButtonItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    if([_html5WebView.request.URL.absoluteString containsString:[NSString stringWithFormat:@"http://mapi.lhgene.cn/m/product"]])
    {
        orderBt.hidden = NO;
        zixunBt.hidden = NO;
    }

    if ([webView.request.URL.absoluteString containsString:@"http://mapi.lhgene.cn/m/db/topic/"]) {
        
        newsContains = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('h3')[0].innerHTML"];
        [[Mixpanel sharedInstance] track:@"用户浏览文章" properties:@{@"news":newsContains}];
    }
    
    loadingView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    loadingView.hidden = YES;
}

- (void)shareBtnAction
{
//    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//    
//        shareView.transform = CGAffineTransformMakeTranslation(0, -(shareView.frame.size.height));
//    } completion:^(BOOL finished){
//        
//    }];
#define Button_SIZE 54*SCREEN_WEIGHT/375
#define Lb_SIZE [UIFont fontWithName:@"STHeitiSC-Light" size:12]
#define weixin_TAG 10
#define pengyouquan_TAG 20
#define QQ_TAG 30
#define kongjian_TAG 40
#define weibo_TAG 50
    aletCtrol = [UIAlertController alertControllerWithTitle:@"分享到\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cacle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    }];
    
    aletCtrol.view.layer.cornerRadius = 10;
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weixinBtn.frame = CGRectMake(20 * SCREEN_WEIGHT/375, 40 *SCREEN_HEIGHT/667, Button_SIZE, Button_SIZE);
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [weixinBtn addTarget:self action:@selector(shareToAppBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    weixinBtn.tag = weixin_TAG;
    [aletCtrol.view addSubview:weixinBtn];
    
    UILabel *weixinLb = [[UILabel alloc] initWithFrame:CGRectMake(23 * SCREEN_WEIGHT/375, 102 *SCREEN_HEIGHT/667, 48, 12)];
    weixinLb.text = @"微信好友";
    weixinLb.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    [aletCtrol.view addSubview:weixinLb];
    
    UIButton *friendCycleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendCycleBtn.frame = CGRectMake(107 * SCREEN_WEIGHT/375, 40 * SCREEN_HEIGHT/667, Button_SIZE, Button_SIZE);
    [friendCycleBtn setBackgroundImage:[UIImage imageNamed:@"penyouquan"] forState:UIControlStateNormal];
    [friendCycleBtn addTarget:self action:@selector(shareToAppBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    friendCycleBtn.tag = pengyouquan_TAG;
    [aletCtrol.view addSubview:friendCycleBtn];
    
    UILabel *friendCycleLb = [[UILabel alloc] initWithFrame:CGRectMake(116 * SCREEN_WEIGHT/375, 102 * SCREEN_HEIGHT/667, 36, 12)];
    friendCycleLb.text = @"朋友圈";
    friendCycleLb.font = Lb_SIZE;
    [aletCtrol.view addSubview:friendCycleLb];
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = CGRectMake(194 *SCREEN_WEIGHT/375, 40 *SCREEN_HEIGHT/667, Button_SIZE, Button_SIZE);
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(shareToAppBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    qqBtn.tag = QQ_TAG;
    [aletCtrol.view addSubview:qqBtn];
    
    UILabel *qqLb = [[UILabel alloc] initWithFrame:CGRectMake(199 *SCREEN_WEIGHT/375, 102 *SCREEN_HEIGHT/667, 43, 12)];
    qqLb.text = @"QQ好友";
    qqLb.font = Lb_SIZE;
    [aletCtrol.view addSubview:qqLb];
    
    UIButton *qqkongjianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqkongjianBtn.frame = CGRectMake(281 *SCREEN_WEIGHT/375, 40 *SCREEN_HEIGHT/667, Button_SIZE, Button_SIZE);
    [qqkongjianBtn setBackgroundImage:[UIImage imageNamed:@"qqkongjian"] forState:UIControlStateNormal];
    [qqkongjianBtn addTarget:self action:@selector(shareToAppBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    qqkongjianBtn.tag = kongjian_TAG;
    [aletCtrol.view addSubview:qqkongjianBtn];
    
    UILabel *qqkongjianLb = [[UILabel alloc] initWithFrame:CGRectMake(287 *SCREEN_WEIGHT/375, 102 *SCREEN_HEIGHT/667, 43, 12)];
    qqkongjianLb.text = @"QQ空间";
    qqkongjianLb.font = Lb_SIZE;
    [aletCtrol.view addSubview:qqkongjianLb];
    
    
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(20 *SCREEN_WEIGHT/375, 131*SCREEN_HEIGHT/667, Button_SIZE, Button_SIZE);
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(shareToAppBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    weiboBtn.tag = weibo_TAG;
    [aletCtrol.view addSubview:weiboBtn];
    
    UILabel *weiboLb = [[UILabel alloc] initWithFrame:CGRectMake(23*SCREEN_WEIGHT/375, 192 *SCREEN_HEIGHT/667, 48, 12)];
    weiboLb.text = @"新浪微博";
    weiboLb.font = Lb_SIZE;
    [aletCtrol.view addSubview:weiboLb];
    
    [aletCtrol addAction:cacle];
    [self presentViewController:aletCtrol animated:YES completion:nil];
    
}

- (void)shareToAppBtnAction:(UIButton *)sender
{
    NSString *shareWeixinUrlStr = [NSString stringWithFormat:@"%@?share=weixin",_html5WebView.request.URL.absoluteString];
    NSString *shareQQUrlStr = [NSString stringWithFormat:@"%@?share=qq",_html5WebView.request.URL.absoluteString];
    [aletCtrol dismissViewControllerAnimated:YES completion:^{
        switch (sender.tag) {
            case weixin_TAG:
            case pengyouquan_TAG:{
                SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                              sendReq.bText = NO;
                 WXMediaMessage *urlMessage = [WXMediaMessage message];
                           urlMessage.title = newsContains;
                     urlMessage.description = @"测试测试测试测试测试测试";
                
                    WXWebpageObject *webObj = [WXWebpageObject object];
                          webObj.webpageUrl = shareWeixinUrlStr;
                     urlMessage.mediaObject = webObj;
                            sendReq.message = urlMessage;
                
                if (sender.tag == weixin_TAG) {
                    sendReq.scene = 0;
                }
                else
                    sendReq.scene = 1;
                
                [WXApi sendReq:sendReq];
                
                NSLog(@" 成功和失败 - %d",[WXApi sendReq:sendReq]);
            }
                break;
            case QQ_TAG:
            case kongjian_TAG:{
                QQApiNewsObject *newObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareQQUrlStr] title:newsContains description:@"测试测试" previewImageURL:[NSURL URLWithString:@"http://lifehealthcare.com/wp-content/uploads/2017/02/健康生活-300x200.jpg"]];
                SendMessageToQQReq *sendRep = [SendMessageToQQReq reqWithContent:newObj];
                if (sender.tag == QQ_TAG) {
                    [QQApiInterface sendReq:sendRep];
                }
                else
                    [QQApiInterface SendReqToQZone:sendRep];
            }
                break;
            case weibo_TAG:{
                                 WBMessageObject *obj = [[WBMessageObject alloc] init];
                            WBWebpageObject *mediaObj = [[WBWebpageObject alloc] init];
                                       mediaObj.title = self.navigationItem.title;
                                 mediaObj.description = @"测试测试";
                                  mediaObj.webpageUrl = shareQQUrlStr;
                                      obj.mediaObject = mediaObj;
                WBSendMessageToWeiboRequest *weiboReq = [WBSendMessageToWeiboRequest requestWithMessage:obj];
                [WeiboSDK sendRequest:weiboReq];
            }
                break;
            default:
                break;
        }
       
    }];
}

-(void)receivedNotif:(NSNotification *)notification {
    hasLogin = YES;
}

@end


