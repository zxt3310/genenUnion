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
#import <objc/runtime.h>

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
    UIButton *shareButton;
    NSString *descriptionStr;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _html5WebView.delegate = self;
    
    [_html5WebView setMediaPlaybackRequiresUserAction:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:
                                              @{NSFontAttributeName:[UIFont systemFontOfSize:19],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];

    //分享按钮
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    //点击追踪
    if([_strURL.absoluteString containsString:[NSString stringWithFormat:@"http://mapi.lhgene.cn/m/product"]])
    {
        descriptionStr = @"莲和医疗致力于肿瘤基因检测在临床医学与健康服务中的推广和应用，为个人及家庭提供个性化健康指导和全方位的干预管理。";
        ProNo = [[_strURL.absoluteString stringByReplacingOccurrencesOfString:@"http://mapi.lhgene.cn/m/product/" withString:@""] integerValue];
        switch (ProNo) {
            case 1:
                newsContains = @"和普安ctDNA无创肿瘤基因检测";
                [[Mixpanel sharedInstance] track:@"首页“和普安”产品图标点击"];
                break;
            case 2:
                newsContains = @"和家安遗传性肿瘤基因检测";
                [[Mixpanel sharedInstance] track:@"首页“和家安”产品图标点击"];
                break;
            case 3:
                newsContains = @"和美安乳腺癌基因检测";
                [[Mixpanel sharedInstance] track:@"首页“和美安”产品图标点击"];
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
    
    if([_strURL.absoluteString isEqualToString:FAQ_PAGE])
    {
        newsContains = @"肿瘤基因超早期检测";
        descriptionStr = @"什么是癌症，癌症是如何发生的？";
        [[Mixpanel sharedInstance] track:@"首页“FAQ”点击"];
    }
    if ([_strURL.absoluteString isEqualToString:advise_URL])
    {
        newsContains = @"女性的节日 莲和的礼物";
        descriptionStr = @"我确定这份奢侈品是你想要的";
        [[Mixpanel sharedInstance] track:@"活动图：活动宣传图点击次数"];
    }
    
    _html5WebView.scalesPageToFit = YES;
    [_html5WebView loadRequest:[NSURLRequest requestWithURL:_strURL]];
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
            [[Mixpanel sharedInstance] track:@"和普安产品详情页“预约取样”点击"];
            break;
        case 2:
            [[Mixpanel sharedInstance] track:@"和家安产品详情页”预约取样“点击"];
            break;
        case 3:
            [[Mixpanel sharedInstance] track:@"和美安产品详情页“预约取样”点击"];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:ovc animated:YES];
}

- (void)zixunBtClick
{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    
//    orderBt.hidden = zixunBt.hidden = YES;
    
    switch (ProNo) {
        case 1:
            [[Mixpanel sharedInstance] track:@"和普安产品详情页“在线咨询”点击"];
            break;
        case 2:
            [[Mixpanel sharedInstance] track:@"和家安产品详情页“在线咨询”点击"];
            break;
        case 3:
            [[Mixpanel sharedInstance] track:@"和美安产品详情页“在线咨询”点击"];
            break;
        default:
            break;
    }

    [chatViewManager pushMQChatViewControllerInViewController:self];
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    NSLog(@"WebViewController URL: %@", _strURL);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.html5WebView.delegate = nil;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme isEqualToString:@"objectc"]) {
        [[Mixpanel sharedInstance] track:@"活动图：活动宣传H5第九页“提交”按钮的点击"];
        return NO;
    }
    self.strURL = request.URL;
    //隐藏分享按钮
    if ([request.URL.absoluteString containsString:@"http://mapi.lhgene.cn/m/my/report"] || [request.URL.absoluteString isEqualToString:@"http://mapi.lhgene.cn/m/news"] || [request.URL.absoluteString isEqualToString:GYWM_PAGE]) {
        shareButton.hidden = YES;
    }
    else
        shareButton.hidden = NO;

    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    loadingView.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"(function(){$('.comp_button').click(function(){window.location.href='objectC://'});})()"]];
    });
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
    //获取文章
    if ([webView.request.URL.absoluteString containsString:@"http://mapi.lhgene.cn/m/db/topic/"]) {
        newsContains = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('h3')[0].innerHTML"];
        NSString *curStr = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('p')[0].innerHTML"];
        NSString *replaceStr = [self flattenHTML:curStr trimWhiteSpace:NO];
        descriptionStr = [replaceStr substringWithRange:NSMakeRange(0, 30)];
        [[Mixpanel sharedInstance] track:@"文章浏览量" properties:@{@"title":newsContains}];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"(function(){$('.comp_button').click(function(){window.location.href='objectC://'});})()"]];
    });
    
    loadingView.hidden = YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    loadingView.hidden = YES;
}

- (void)shareBtnAction
{
//    unsigned int count = 0;
//    Method *memberFuncs = class_copyMethodList([self class], &count);
//    for (int i=0; i<count; i++) {
//        SEL name = method_getName(memberFuncs[i]);
//        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
//        NSLog(@"member method:%@",methodName);
//    }
#define Button_SIZE 54*SCREEN_WEIGHT/375
#define Lb_SIZE [UIFont fontWithName:@"STHeitiSC-Light" size:12]
#define weixin_TAG 10
#define pengyouquan_TAG 20
#define QQ_TAG 30
#define kongjian_TAG 40
#define weibo_TAG 50
    aletCtrol = [UIAlertController alertControllerWithTitle:@"分享到\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
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
    [self shareTrack:sender.tag];
    
    NSString *shareWeixinUrlStr = [NSString stringWithFormat:@"%@?share=weixin",_strURL.absoluteString];
    NSString *shareQQUrlStr = [NSString stringWithFormat:@"%@?share=qq",_strURL.absoluteString];
    NSString *shareWeiboUrlStr = [NSString stringWithFormat:@"%@?share=weibo",_strURL.absoluteString];
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"120"]);
    [aletCtrol dismissViewControllerAnimated:YES completion:^{
        switch (sender.tag) {
            case weixin_TAG:
            case pengyouquan_TAG:{
                if (![WXApi isWXAppInstalled]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
                    return;
                }
                SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                              sendReq.bText = NO;
                 WXMediaMessage *urlMessage = [WXMediaMessage message];
                           urlMessage.title = newsContains;
                       urlMessage.thumbData = imageData;
                     urlMessage.description = descriptionStr;
                    WXWebpageObject *webObj = [WXWebpageObject object];
                          webObj.webpageUrl = shareWeixinUrlStr;
                     urlMessage.mediaObject = webObj;
                            sendReq.message = urlMessage;
                
                if (sender.tag == weixin_TAG) {
                    sendReq.scene = 0;
                }
                else
                    sendReq.scene = 1;
                
                NSLog(@" 成功和失败 - %d",[WXApi sendReq:sendReq]);
            }
                break;
            case QQ_TAG:
            case kongjian_TAG:{
                if (![QQApiInterface isQQInstalled]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[QQApiInterface getQQInstallUrl]]];
                    return;
                }
                QQApiNewsObject *newObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareQQUrlStr] title:newsContains description:descriptionStr previewImageData:imageData];
                SendMessageToQQReq *sendRep = [SendMessageToQQReq reqWithContent:newObj];
                if (sender.tag == QQ_TAG) {
                    [QQApiInterface sendReq:sendRep];
                }
                else
                    [QQApiInterface SendReqToQZone:sendRep];
            }
                break;
            case weibo_TAG:{
                                 WBMessageObject *obj = [WBMessageObject message];
                              WBImageObject *imageObj = [WBImageObject object];
                                   imageObj.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"120"]);
                                      obj.imageObject = imageObj;
                                             obj.text = [NSString stringWithFormat:@"%@ %@",newsContains,shareWeiboUrlStr];
                WBSendMessageToWeiboRequest *weiboReq = [WBSendMessageToWeiboRequest requestWithMessage:obj];
                @try {
                    [WeiboSDK sendRequest:weiboReq];
                } @catch (NSException *exception) {
                    NSLog(@"%@",exception);
                    return;
                } @finally {
                    
                }                
            }
                break;
            default:
                break;
        }
    }];
}

- (void)shareTrack:(NSInteger) tag
{
    NSString *shareTo;
    switch (tag) {
        case 10:
            shareTo = @"微信";
            break;
        case 20:
            shareTo = @"朋友圈";
            break;
        case 30:
            shareTo = @"QQ";
            break;
        case 40:
            shareTo = @"QQ空间";
            break;
        case 50:
            shareTo = @"新浪微博";
            break;
        default:
            break;
    }
    NSString *urlStr = _html5WebView.request.URL.absoluteString;
    if ([urlStr isEqualToString:FAQ_PAGE]) {
        [[Mixpanel sharedInstance] track:@"转发：FAQ页面转发按钮的点击" properties:@{@"ShareTo":shareTo}];
    }
    else if ([urlStr isEqualToString:PRODUCT1_URL])
    {
        [[Mixpanel sharedInstance] track:@"转发：和普安转发按钮的点击" properties:@{@"ShareTo":shareTo}];
    }
    else if ([urlStr isEqualToString:PRODUCT2_URL])
    {
        [[Mixpanel sharedInstance] track:@"转发：和美安转发按钮的点击" properties:@{@"ShareTo":shareTo}];
    }
    else if ([urlStr isEqualToString:PRODUCT3_URL])
    {
        [[Mixpanel sharedInstance] track:@"转发：和家安转发按钮的点击" properties:@{@"ShareTo":shareTo}];
    }
    else if ([urlStr containsString:@"http://mapi.lhgene.cn/m/db/topic/"])
    {
        [[Mixpanel sharedInstance] track:@"所有文章转发" properties:@{@"title":newsContains,@"ShareTo":shareTo}];
    }
}

-(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


