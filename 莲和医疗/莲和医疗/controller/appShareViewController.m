//
//  appShareViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2017/3/6.
//  Copyright © 2017年 莲和医疗. All rights reserved.
//

#import "appShareViewController.h"
#define shareFont  [UIFont fontWithName:@"STHeitiSC-Light" size:16]
#define shareColor [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1]
@interface appShareViewController ()

@end
@implementation unitButton
{
    UIImageView *imageView;
    UILabel *appTitle;
}
@synthesize imageName = _imageName;
@synthesize appName = _appName;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = shareColor.CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(22 *SCREEN_WEIGHT/375,
                                                                  11 *SCREEN_HEIGHT/667,
                                                                  30 *SCREEN_WEIGHT/375,
                                                                  30 *SCREEN_HEIGHT/667)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        appTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                             51 *SCREEN_HEIGHT/667,
                                                             self.frame.size.width,
                                                             14 *SCREEN_HEIGHT/667)];
            appTitle.textColor = shareColor;
                 appTitle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        appTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:appTitle];
    }
    return self;
}

- (NSString *)imageName:(NSString *)imageName{
    return _imageName;
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    imageView.image = [UIImage imageNamed:imageName];
}

- (NSString *)appName:(NSString *)appName{
    return _appName;
}
- (void)setAppName:(NSString *)appName{
    _appName = appName;
    appTitle.text = appName;
}

@end

@implementation appShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享给好友";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               107 *SCREEN_HEIGHT/667,
                                                               SCREEN_WEIGHT,
                                                               16 *SCREEN_HEIGHT/667)];
    lable.text = @"每一次分享都承载着你对朋友的关心";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = shareColor;
    lable.font = shareFont;
    [self.view addSubview:lable];
    
    NSArray *appImgAry = @[@"shareWX",@"sharePY",@"shareQQ",@"shareKJ",@"shareWB"];
    NSArray *appNameAry = @[@"微信好友",@"朋友圈",@"QQ",@"QQ空间",@"新浪微博"];
    
    for (int i=0; i<5; i++) {
        unitButton *shareAppTF = [[unitButton alloc] initWithFrame:CGRectMake(151 *SCREEN_WEIGHT/375,
                                                                              (168 + i*83)*SCREEN_HEIGHT/667,
                                                                              73 *SCREEN_WEIGHT/375,
                                                                              73 *SCREEN_WEIGHT/375)];
        shareAppTF.imageName = appImgAry[i];
        shareAppTF.appName = appNameAry[i];
        shareAppTF.tag = (i+1)*10;
        [shareAppTF addTarget:self action:@selector(shareAPP:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shareAppTF];
    }
    
}

- (void)shareAPP:(UIButton *)sender{
#define weixin_TAG 10
#define pengyouquan_TAG 20
#define QQ_TAG 30
#define kongjian_TAG 40
#define weibo_TAG 50
    NSString *newsContains = @"健康不是第一，而是唯一";
    NSString *descriptionStr = @"可以把人生的财富和名誉看作无数个“0”，然而只有健康才是“1”。如果没有“1”，就算有无数个“0”也毫无意义。";
    NSString *shareAppUrl = @"http://mapi.lhgene.cn:8088/m/app/share";
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"180"]);
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
                      webObj.webpageUrl = shareAppUrl;
                 urlMessage.mediaObject = webObj;
                        sendReq.message = urlMessage;
            
            if (sender.tag == weixin_TAG) {
                sendReq.scene = 0;
            }
            else
                sendReq.scene = 1;
            
            [WXApi sendReq:sendReq];
        }
            break;
        case QQ_TAG:
        case kongjian_TAG:{
            if (![QQApiInterface isQQInstalled]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[QQApiInterface getQQInstallUrl]]];
                return;
            }
            QQApiNewsObject *newObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareAppUrl]
                                                               title:newsContains
                                                         description:descriptionStr
                                                    previewImageData:imageData];
            
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
                               imageObj.imageData = imageData;
                                  obj.imageObject = imageObj;
                                         obj.text = [NSString stringWithFormat:@"%@ %@",newsContains,shareAppUrl];
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

}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
