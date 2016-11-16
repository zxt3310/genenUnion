//
//  MainViewController.h
//  UFanDrawer
//
//  Created by zxt on 15/8/21.
//  Copyright (c) 2015年 zxt. All rights reserved.
//

#import "UFanBasicViewController.h"
#import "WebViewJavascriptBridge.h"
#import "CMCustomViews.h"
#import "firstItemViewController.h"
#import "Reachability.h"
#import "UIViewController+UFanViewController.h"
#import "CMCustomViews.h"
#import "CMImageUtils.h"
#import "userLoginView.h"
#import "CustomURLCache.h"
#import "orderViewController.h"
#import "reportListViewController.h"

@interface MainViewController : UFanBasicViewController<UIWebViewDelegate,FFGlobalLoginDelegate>
{
    UIBarButtonItem *leftBarButton;
    WebViewJavascriptBridge *jsBridge;
    LoadingView *loadingView;
    NSURL *URL;
    BOOL isMainPage;
    Reachability *hostReach;
    BOOL isNeedReload;
    
    NSString *lastToken;
    BOOL hasLogin;
}
@property (nonatomic, strong) NSString *strURL;
@property (strong, nonatomic) IBOutlet UIWebView *html5View123;

@property UIWebView *html5View;

@property UINavigationBar *bar;
@property UIImage *barColor;

- (void)setStrURL:(NSString *)strURL;


@end
