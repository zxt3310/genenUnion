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

@interface MainViewController : UFanBasicViewController<UIWebViewDelegate>
{
    UIBarButtonItem *leftBarButton;
    WebViewJavascriptBridge *jsBridge;
    LoadingView *loadingView;
    NSURL *URL;
    BOOL isMainPage;
    Reachability *hostReach;
    BOOL isNeedReload;
}
@property (nonatomic, strong) NSString *strURL;
@property (strong, nonatomic) IBOutlet UIWebView *html5View;

@property UINavigationBar *bar;
@property UIImage *barColor;

- (void)setStrURL:(NSString *)strURL;


@end
