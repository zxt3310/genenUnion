//
//  appUpdateViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2017/3/3.
//  Copyright © 2017年 莲和医疗. All rights reserved.
//

#import "appUpdateViewController.h"

@interface appUpdateViewController ()
{
    UILabel *updateLB;
    UIButton *updateBtn;
    NSString *current_version;
    NSString *update_Url;
    LoadingView *loadingView;
}
@end

@implementation appUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"检查更新"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSDictionary *appInfoDic = [[NSBundle mainBundle] infoDictionary];
    current_version = [appInfoDic objectForKey:@"CFBundleShortVersionString"]; //当前版本

    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(144 *SCREEN_WEIGHT/375,
                                                                          194 *SCREEN_HEIGHT/667,
                                                                          87*SCREEN_WEIGHT/375,
                                                                          87*SCREEN_WEIGHT/375)];
    iconView.image = [UIImage imageNamed:@"logoUp"];
    [self.view addSubview:iconView];
    
    updateLB = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                         341*SCREEN_HEIGHT/667,
                                                         SCREEN_WEIGHT,
                                                         16*SCREEN_HEIGHT/667)];
            updateLB.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
                 updateLB.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16*SCREEN_HEIGHT/667];
        updateLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:updateLB];
    //跟新按钮
          updateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    updateBtn.frame = CGRectMake(121 *SCREEN_WEIGHT/375,
                                 378*SCREEN_HEIGHT/667,
                                 133*SCREEN_WEIGHT/375,
                                 40*SCREEN_HEIGHT/667);
             updateBtn.tintColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
       updateBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    updateBtn.layer.cornerRadius = 20;
     updateBtn.layer.borderWidth = 1;
     updateBtn.layer.borderColor = updateBtn.tintColor.CGColor;
                updateBtn.hidden = YES;
    [updateBtn setTitle:@"下载更新" forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(appUpdate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
    //版本
     UILabel *versionLB = [[UILabel alloc] initWithFrame:CGRectMake(144 *SCREEN_WEIGHT/375,
                                                                   620*SCREEN_HEIGHT/667,
                                                                   SCREEN_WEIGHT,
                                                                   14 *SCREEN_HEIGHT/667)];
    versionLB.textColor = updateLB.textColor;
         versionLB.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
         versionLB.text = [NSString stringWithFormat:@"当前版本%@",current_version];;
    [self.view addSubview:versionLB];
    
    //loading 动画
    float topY = updateLB.frame.origin.y;
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/2-40, topY, 80, 70)];
    loadingView.hidden = YES;
    loadingView.dscpLabel.text = @"检查更新";
    [self.view addSubview:loadingView];
    
    [self checkUpdate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)checkUpdate
{
    loadingView.hidden = NO;
    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%@",appStore_Version_POST_URL,appleID];// @"http://itunes.apple.com/cn/lookup?id=1203188094";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        NSData *responseData = sendRequestWithFullURL(urlStr, nil);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!responseData) {
                NSLog(@"netWork doesn't work");
                updateLB.text = @"无法连接服务器，请检查网络或稍后再试";
                loadingView.hidden = YES;
                return ;
            }
            
            NSDictionary *returnDic = parseJsonResponse(responseData);
            if (!returnDic) {
                NSLog(@"return Wrong Data");
                updateLB.text = @"连接失败，请重试";
                loadingView.hidden = YES;
                return;
            }
            
            NSNumber *resault = JsonValue([returnDic objectForKey:@"resultCount"],@"NSDictionary");
            if (!resault) {
                NSLog(@"return Wrong Data Check API");
                updateLB.text = @"返回数据格式错误，请稍后再试";
                loadingView.hidden = YES;
                return;
            }
            
            NSInteger code = [resault integerValue];
            if (code == 0) {
                NSString *errmsg = @"fail to check version";
                NSLog(@"%@",errmsg);
                loadingView.hidden = YES;
                return;
            }
            
            NSArray *stroeInfoDic = JsonValue([returnDic objectForKey:@"results"],@"NSDictionary");
            if (stroeInfoDic.count == 0) {
                NSLog(@"this app is not exist in appstore");
                updateLB.text = @"fail to checkUpdate";
                loadingView.hidden = YES;
                return;
            }
            NSString *newVersion = [stroeInfoDic[0] objectForKey:@"version"];
            update_Url = [stroeInfoDic[0] objectForKey:@"trackViewUrl"];
            
            if ([newVersion isEqualToString:current_version]) {
                updateLB.text = @"你已经是最新版本了，返回首页有惊喜！";
            }
            else
            {
                updateLB.text = @"发现新版本，快去看一下！";
                updateBtn.hidden = NO;
            }
            loadingView.hidden = YES;
        });
    });
}

- (void)appUpdate{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:update_Url]];
}

@end
