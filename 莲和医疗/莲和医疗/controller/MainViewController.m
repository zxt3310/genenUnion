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

@end

@implementation MainViewController


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
//                                                                     diskCapacity:200 * 1024 * 1024
//                                                                         diskPath:nil
//                                                                        cacheTime:0];
//        [CustomURLCache setSharedURLCache:urlCache];
//    }
//    return self;
//}


- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
    _html5View123.hidden = YES;
    
    _html5View = [[UIWebView alloc ]initWithFrame: CGRectMake(0, 64, SCREEN_WEIGHT, SCREEN_HEIGHT - 64)];

    [self.view addSubview:_html5View];
    
    isMainPage = YES;
    _html5View.delegate = self;
    
    hostReach = [Reachability reachabilityWithHostname:MAIN_PAGE];
    
    //监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
    [hostReach startNotifier];
    isNeedReload = NO;
    
    [self setNewBar];
    
    hasLogin = NO;
    
     
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
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    titleLabel.text = @"和普安";
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
    
    
    /* 两种设置button的方式 上面更适合图片 下面的方式会造成button为不变的蓝色
    UIImage *image2 = [UIImage imageNamed:@"SIDE-list.png"];
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithImage:image2
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(leftAction)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    negativeSpacer.width = 0 ;//这个数值可以根据情况自由变化
    negativeSpacer.customView.backgroundColor = [UIColor whiteColor];
    self.UF_ViewController.navigationItem.leftBarButtonItems = @[negativeSpacer,navLeftButton];
    
    */
    
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
    //[finalStrURL appendFormat:@"&appid=4"];
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
    
    [self setLeftBarButtonItem];
    
     self.navigationController.navigationBar.hidden = YES;
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if (!jsBridge) {
//        jsBridge = [WebViewJavascriptBridge bridgeForWebView:_html5View webViewDelegate:self handler:^(id data, WVJBResponse *response) {
//            NSLog(@"ObjC received message from JS: %@", data);
//            //[self processJSEvent:data];
//            
//          
//        }];
//    }
    
    
        URL = [[NSURL alloc] initWithString:_strURL];
        
        NSLog(@"WebViewController URL: %@", URL);
//        if(hostReach.isReachable)
//        {
            _html5View.scalesPageToFit = YES;
            [_html5View loadRequest:[NSURLRequest requestWithURL:URL]];
          
//        }
//        else
//        {
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//            
//            NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//            
//            NSString *basePath = [[NSBundle mainBundle] bundlePath];
//            
//            NSURL *baseURL = [NSURL fileURLWithPath:basePath];
//            
//            [self.html5View loadHTMLString:htmlString baseURL:baseURL];
//            URL = baseURL;
//        }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    isMainPage = false;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *currentUrl = request.URL;
    //NSURL *url = [[NSURL alloc] initWithString:@"http://gzh.gentest.ranknowcn.com/resources/mobile/index"];
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
            [self presentViewController:unv animated:YES completion:nil];
            
        }
        isMainPage = NO;
        return NO;
    }

   
    if (![currentUrl isEqual:URL] & ![a isEqualToString:@"about:blank"])
    {
        firstItemViewController *firstVC = [firstItemViewController new]; //initWithNibName:@"firstItemViewController" bundle:nil];
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



@end
