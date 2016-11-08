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

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WEIGHT [[UIScreen mainScreen] bounds].size.width
@interface MainViewController ()

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];
    }
    return self;
}


- (void)viewDidLoad {
   
    
    [super viewDidLoad];
   
    [self setLeftBarButtonItem];
    isMainPage = YES;
    _html5View.delegate = self;
    
    hostReach = [Reachability reachabilityWithHostname:@"http://gzh.gentest.ranknowcn.com/resources/mobile/index"];
    
    //监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
    [hostReach startNotifier];
    isNeedReload = NO;
    
    // Do any additional setup after loading the view.
     
}

- (void)setLeftBarButtonItem{
    
    
    UIImage *image2 = [UIImage imageNamed:deviceImageSelect(@"iconfontMulu.png")];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 32, 32);
    [closeBtn setImage:image2 forState:UIControlStateNormal];
    [closeBtn setHidden:NO];
    [closeBtn setTitle:@"" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.UF_ViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    
    UIImage *imageYx = [UIImage imageNamed:deviceImageSelect(@"iconfontYouxiang.png")];
    UIButton *eMailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eMailBtn.frame = CGRectMake(0, 0, 18, 14);
    [eMailBtn setImage:imageYx forState:UIControlStateNormal];
    [eMailBtn setHidden:NO];
    [eMailBtn addTarget:self action:@selector(eMailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.UF_ViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:eMailBtn];
    
    
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


- (void)leftAction{
    [self.UF_ViewController triggerLeftDrawer];
}

- (IBAction)sideMenuButtonClick:(id)sender
{
    [self leftAction];
}

- (void)eMailBtnClick
{
    orderViewController *ovc = [[orderViewController alloc]init];
    
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
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!jsBridge) {
        jsBridge = [WebViewJavascriptBridge bridgeForWebView:_html5View webViewDelegate:self handler:^(id data, WVJBResponse *response) {
            NSLog(@"ObjC received message from JS: %@", data);
            //[self processJSEvent:data];
            
          
        }];
    }
    
    
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
