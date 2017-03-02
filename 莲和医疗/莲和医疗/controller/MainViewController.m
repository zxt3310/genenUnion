//
//  MainViewController.m
//  UFanDrawer
//
//  Created by zxt on 15/8/21.
//  Copyright (c) 2015年 zxt. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+UFanViewController.h"
#import "CMCustomViews.h"
#import "CMImageUtils.h"
#import "userLoginView.h"
#import "CustomURLCache.h"
#import "orderViewController.h"
#import "reportListViewController.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WEIGHT [[UIScreen mainScreen] bounds].size.width
@interface MainViewController ()
{
    UIButton *backBtn;
    NSURL * urlLocal;
}
@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];
            hasLogin = NO;
        urlLocal = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ios_index" ofType:@"html"inDirectory:@"h5_main/html"]];
        
    }
    return self;
}


- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewMQMessages:) name:MQ_RECEIVED_NEW_MESSAGES_NOTIFICATION object:nil];
    
    _html5View123.hidden = YES;
    
    _html5View = [[UIWebView alloc ]initWithFrame: CGRectMake(0, 64, SCREEN_WEIGHT, SCREEN_HEIGHT - 64)];

    [self.view addSubview:_html5View];
    
    isMainPage = YES;
    _html5View.delegate = self;
    
    //监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
    
    //监听登陆操作
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateToken:) name:@"updateToken" object:nil];
    
    [hostReach startNotifier];
    isNeedReload = NO;

    [self setNewBar];
    
}

- (void)setNewBar
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 65)];
    UIImageView *backimg = [[UIImageView alloc]initWithFrame:header.frame];
    backimg.backgroundColor = [UIColor colorWithPatternImage:_barColor];
    header.layer.borderColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:0.5].CGColor;
    header.layer.borderWidth = 0;
    [self.view addSubview:header];
    [header addSubview:backimg];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:@"iconfontMulu.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"iconfontMulu.png"] forState:UIControlStateHighlighted];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 7, 8)];
    [backBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn sizeToFit];
    CGRect rect = backBtn.frame;
    rect.origin.y = 20;
    rect.size.height = 44;
    rect.size.width = rect.size.width + 33;
    backBtn.frame = rect;
    [header addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width + 16, 20, SCREEN_WEIGHT - (rect.size.width+8) * 2, 44)];
    titleLabel.text = @"莲和基因";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:titleLabel];
}

- (void)setLeftBarButtonItem{
    
    
    UIImage *image2 = [UIImage imageNamed:deviceImageSelect(@"iconfontMulu.png")];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 32, 32);
    [closeBtn setImage:image2 forState:UIControlStateNormal];
    [closeBtn setHidden:NO];
    [closeBtn setTitle:@"" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    [self.bar.topItem setLeftBarButtonItem:item];
    
    
    UIImage *imageYx = [UIImage imageNamed:deviceImageSelect(@"iconfontYouxiang.png")];
    UIButton *eMailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eMailBtn.frame = CGRectMake(0, 0, 18, 14);
    [eMailBtn setImage:imageYx forState:UIControlStateNormal];
    [eMailBtn setHidden:NO];
    [eMailBtn addTarget:self action:@selector(eMailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.bar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:eMailBtn];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.html5View.scrollView setContentInset:UIEdgeInsetsZero];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = YES;
}

- (void)leftAction{
    [self.UF_ViewController triggerLeftDrawer];
}

- (IBAction)sideMenuButtonClick:(id)sender
{
    [self leftAction];
}

- (void)eMailBtnClick
{
    reportListViewController *ovc = [[reportListViewController alloc]init];

    [self.UF_ViewController.navigationController pushViewController:ovc animated:YES];
}
#pragma mark - WEB METHOD FROM HELTHYBOY


- (void)setStrURL:(NSString *)strURL
{
    NSMutableString *finalStrURL = [[NSMutableString alloc] initWithString:strURL];
    
    // 添加URL标识
     _strURL = [finalStrURL copy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    lastToken = getStringForKey(@"token");
    if (lastToken !=nil)
    {
        hasLogin = YES;
    }
    else
    {
        hasLogin = NO;
    }
    
     self.navigationController.navigationBar.hidden = YES;
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    hostReach = [Reachability reachabilityWithHostname:@"http://mapi.lhgene.cn"];
    
        URL = [[NSURL alloc] initWithString:_strURL];
        
        NSLog(@"WebViewController URL: %@", URL);
    
        NSInteger appUseCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"count"] integerValue];
        if(!hostReach.isReachable)
        {
            if(appUseCount == 0)
            {                
                NSURLRequest *request = [NSURLRequest requestWithURL:urlLocal];
                
                [_html5View loadRequest:request];
                
                return;
            }
        }
        _html5View.scalesPageToFit = YES;
        [_html5View loadRequest:[NSURLRequest requestWithURL:URL]];
        appUseCount ++;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)appUseCount] forKey:@"count"];
        [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    isMainPage = false;
    if(!lastToken)
    {
        lastToken = @"";
    }
    
    NSString *js = [NSString stringWithFormat:@"report_count_show('%@');",lastToken];
    [self.html5View stringByEvaluatingJavaScriptFromString:js];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.html5View loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strURL]]];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *currentUrl = request.URL;
    NSString *a = currentUrl.absoluteString;
    
    if([currentUrl.absoluteString isEqualToString:WDJC_PAGE])
    {
        if(hasLogin)
        {
            reportListViewController *rlvc = [[reportListViewController alloc]init];
            rlvc.token = lastToken;
            [self.UF_ViewController.navigationController pushViewController:rlvc animated:YES];
        }
        else
        {
            userLoginView *uLv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
            UINavigationController *unv = [[UINavigationController alloc] initWithRootViewController:uLv];
            unv.navigationBar.hidden = YES;
            uLv.delegate = self;
            [self presentViewController:unv animated:YES completion:nil];
            
        }
        isMainPage = NO;
        return NO;
    }
    
    if([currentUrl.absoluteString isEqualToString:ZXZX_PAGE])
    {
        MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
        [chatViewManager pushMQChatViewControllerInViewController:self];
        [[Mixpanel sharedInstance] track:@"首页“在线咨询”点击"];
        return NO;
    }
   
    if (![currentUrl isEqual:URL] & ![currentUrl isEqual:urlLocal] & ![a isEqualToString:@"about:blank"])
    {
        firstItemViewController *firstVC = [firstItemViewController new];
        firstVC.strURL = request.URL;
        [self.UF_ViewController.navigationController pushViewController:firstVC animated:YES];
        
        isMainPage = NO;
        return NO;
    }
    
    if(isMainPage)
    {
        return YES;
    }
    else if (isNeedReload)
    {
        isNeedReload = NO;
        return YES;
    }
  
    return NO;
}

- (void)reachabilityChanged
{
    if(!isMainPage)
    {
    isNeedReload = YES;
    }
}

- (void)updateToken:(NSNotification *)notification
{
    lastToken = getStringForKey(@"token");
    NSString *currentToken;
    if (lastToken !=nil)
    {
        hasLogin = YES;
        currentToken = lastToken;
    }
    else
    {
        hasLogin = NO;
        currentToken = @"";
    }
    
    NSString *js = [NSString stringWithFormat:@"report_count_show('%@');",currentToken];
    [self.html5View stringByEvaluatingJavaScriptFromString:js];

}

- (void)didReceiveNewMQMessages:(NSNotification *)notification{

    [MQManager getUnreadMessagesWithCompletion:^(NSArray *messages, NSError *error){
    
        NSLog(@"%lu",(unsigned long)messages.count);
    }];
    
}


-(void)loginPushReport:(NSString *)token
{
    reportListViewController *rlvc = [[reportListViewController alloc]init];
    rlvc.token = token;
    [self.UF_ViewController.navigationController pushViewController:rlvc animated:YES];
}

@end
