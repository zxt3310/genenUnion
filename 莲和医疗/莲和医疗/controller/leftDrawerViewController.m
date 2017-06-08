//
//  leftDrawerViewController.m
//  UFanDrawer
//
//  Created by zxt on 15/8/21.
//  Copyright (c) 2015年 zxt. All rights reserved.
//

#import "leftDrawerViewController.h"

@interface leftDrawerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIColor *starColor;
    UIColor *midColor;
    UIColor *endColor;
    UIButton *loginBtn;
    UILabel *userLB;
}
//@property (nonatomic, strong) UITableView *tableView;

@end

@implementation leftDrawerViewController

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotif:) name:@"ReloadView" object:nil];
    self.view.backgroundColor = [UIColor grayColor];
//    self.items = @[@"",FWLC_PAGE,@"联系我们",ZXZX_PAGE,GYWM_PAGE,@"检查更新",@"分享给好友",@"意见反馈",LOIGN_PAGE];
//    self.itemsMenu = @[@"",@"服务流程",@"联系我们",@"在线咨询",@"关于我们",@"检查更新",@"分享给好友",@"意见反馈",@"登        录"];
//    self.itemsImageName =@[@"",FWLC_IMAGE,LXWM_IMAGE,ZXZX_IMAGE,GYWM_IMAGE,@"",@"",@"",LOIGN_IMAGE];

    userLoginView *uLv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
    unv = [[UINavigationController alloc] initWithRootViewController:uLv];
    unv.navigationBar.hidden = YES;

    hasLogin = NO;
    lastUserPhone = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNo"]];
    lastToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (lastToken !=nil & lastUserPhone !=nil)
    {
        hasLogin = YES;
    }

    starColor = [UIColor whiteColor];
    midColor = [UIColor colorWithRed:140.0/255 green:121.0/255 blue:214.0/255 alpha:1];
    endColor = [UIColor colorWithRed:114.0/255 green:97.0/255 blue:179.0/255 alpha:1];
    
    UIImage *leftImage = drawImageWithColor(starColor, midColor, endColor, self.view.frame);
    self.view.backgroundColor = [UIColor colorWithPatternImage:leftImage];
    
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(148 *SCREEN_WEIGHT/375,
                                                                           56 *SCREEN_HEIGHT/667,
                                                                           83 *SCREEN_WEIGHT/375,
                                                                           77 *SCREEN_HEIGHT/667)];
    logoImage.image = [UIImage imageNamed:@"101"];
    [self.view addSubview:logoImage];
    
    userLB = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                       149 *SCREEN_HEIGHT/667,
                                                       self.view.frame.size.width,
                                                       14 *SCREEN_HEIGHT/667)];
    userLB.textAlignment = NSTextAlignmentCenter;
    userLB.textColor = [UIColor colorWithMyNeed:74 green:74 blue:74 alpha:1];
    userLB.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14 *SCREEN_HEIGHT/667];
    if (hasLogin) {
        NSString *phoneNo = [lastUserPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        userLB.text = [NSString stringWithFormat:@"欢迎您，%@",phoneNo];
    }
    else{
        userLB.text = @"请先登录";
    }
    [self.view addSubview:userLB];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    loginBtn.layer.cornerRadius = 15 *SCREEN_WEIGHT/375;
    loginBtn.tintColor = [UIColor whiteColor];
    loginBtn.tag = 80;
    loginBtn.frame = CGRectMake(135 *SCREEN_WEIGHT/375,
                                192 *SCREEN_HEIGHT/667,
                                110 *SCREEN_WEIGHT/375,
                                30 *SCREEN_HEIGHT/667);
    if (!hasLogin) {
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    else
        [loginBtn setTitle:@"注销" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(menuBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 64, 64);
    cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(34, 14, 16, 36);
    [cancelBtn setImage:[UIImage imageNamed:@"sidecancel"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(sideCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    [self setMenuBtnView];
}

- (void)sideCancelAction{
    [self.UF_ViewController disMissLeftDrawer];
}

- (void)setMenuBtnView{
    NSArray *menuImgAry = @[FWLC_IMAGE,LXWM_IMAGE,ZXZX_IMAGE,GYWM_IMAGE,FX_IMAGE,FEEDBACK_IMAGE];//,BBGX_IMAGE];
    NSArray *menuLbText = @[@"服务流程",@"联系我们",@"在线咨询",@"关于我们",@"分享给好友",@"帮助与反馈"];//,@"版本更新"];
    for (int i = 0; i<menuLbText.count; i++) {
        int n = i%2;
        int j = i/2;
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        menuBtn.frame = CGRectMake((65 + n * 176)*SCREEN_WEIGHT/375,
                                   (289 + j * 90)*SCREEN_HEIGHT/667,
                                    70 *SCREEN_WEIGHT/375,
                                    55 *SCREEN_HEIGHT/667);
        menuBtn.tag = (i+1)*10;
        [menuBtn addTarget:self action:@selector(menuBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuBtn];
        
        UIImageView *menuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(21 *SCREEN_WEIGHT/375,
                                                                                 0,
                                                                                 28 *SCREEN_WEIGHT/375,
                                                                                 28 *SCREEN_WEIGHT/375)];
        menuImgView.image = [UIImage imageNamed:menuImgAry[i]];
        [menuBtn addSubview:menuImgView];
        
        UILabel *menuLB = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    40 *SCREEN_HEIGHT/667,
                                                                    70 *SCREEN_WEIGHT/375,
                                                                    15 *SCREEN_WEIGHT/375)];
        menuLB.textColor = [UIColor whiteColor];
        menuLB.textAlignment = NSTextAlignmentCenter;
        menuLB.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:14*SCREEN_WEIGHT/375];
        menuLB.text = menuLbText[i];
        [menuBtn addSubview:menuLB];
    }
}

- (void)loginBtnClickAction:(UIButton *)sender{
    if(!hasLogin)
    {
        userLoginView *uLv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
        unv = [[UINavigationController alloc] initWithRootViewController:uLv];
        unv.navigationBar.hidden = YES;
        uLv.isReportTap = NO;
        [self.navigationController presentViewController:unv animated:YES completion:nil];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhoneNo"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateToken" object:nil];
        [sender setTitle:@"登录" forState:UIControlStateNormal];
        [self alertMsgView:@"您已成功注销"];
    }
}

- (void)menuBtnClickAction:(UIButton *)sender{
    
    [self.UF_ViewController closeDrawerAnimtaion:YES complete:^(BOOL finished){
         if(finished)
         {
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                switch (sender.tag) {
                    case 10:{
                        serviceHelperNewViewController *shvc = [[serviceHelperNewViewController alloc] init];
                        [self.UF_ViewController.navigationController pushViewController:shvc animated:YES];
                    }
                        break;
                    case 20:{
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:400-601-0982"]];
                    }
                        break;
                    case 30:{
                        MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
                        [chatViewManager pushMQChatViewControllerInViewController:self];
                        [[Mixpanel sharedInstance] track:@"首页“在线咨询”点击"];
                    }
                        break;
                    case 40:{
                        firstItemViewController *firstVC = [[firstItemViewController alloc] initWithNibName:@"firstItemViewController" bundle:nil];
                        firstVC.strURL = [NSURL URLWithString:GYWM_PAGE];
                        [self.UF_ViewController.navigationController pushViewController:firstVC animated:YES];
                    }
                        break;
                    case 50:{
                        appShareViewController *auvc = [[appShareViewController alloc] init];
                        [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
                    }
                        break;
                    case 60:{
                        FeedbackViewController *auvc = [[FeedbackViewController alloc] init];
                        [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
                    }
                        break;
                    case 70:{
                        appUpdateViewController *auvc = [[appUpdateViewController alloc] init];
                        [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
                    }
                        break;
                    default:
                        [self loginBtnClickAction:loginBtn];
                        break;
                }
              });
         }
    }];
}

//第一版侧栏-------------------------------------------------------------------------------------------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(indexPath.row < self.items.count-1)
    {
        cell.textLabel.text = (NSString *)self.itemsMenu[indexPath.row];       //设置cell文字
    }
    else
    {
        if (hasLogin)
        {
            cell.textLabel.text = @"注        销";
        }
        else
        {
            cell.textLabel.text = (NSString *)self.itemsMenu[indexPath.row];
        }
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;                   //文字剧中
    cell.textLabel.textColor = [UIColor whiteColor];                       //文字颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.2];  //点击时颜色
    cell.backgroundColor = nil; //[UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:0]; //cell背景色
    if(!indexPath.row)
    {
        cell.userInteractionEnabled = NO;
    }
    
    cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/5, SCREEN_HEIGHT/31, SCREEN_HEIGHT/31.76, SCREEN_HEIGHT/31.76)];   //侧边栏图标
    
    cellImageView.image =[UIImage imageNamed:self.itemsImageName[indexPath.row]];
    [cell.contentView addSubview:cellImageView];
    return cell;
}
//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return  SCREEN_HEIGHT * 20/667;
    }
    return SCREEN_HEIGHT/10;
}

- (void)func:(void (^)())block
{
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row < self.items.count - 1)
    {
    
        [self.UF_ViewController closeDrawerAnimtaion:YES complete:^(BOOL finished)
        {
            if(finished)
            {
                NSString *cellText = self.items[indexPath.row];
                NSURL *url = [[NSURL alloc]initWithString:cellText];
                
                if ([cellText isEqualToString:WDJC_PAGE])
                {
                    if(hasLogin)
                    {
                        reportListViewController *rlvc = [[reportListViewController alloc]init];
                        rlvc.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                        [self.UF_ViewController.navigationController pushViewController:rlvc animated:YES];
                    }
                    else
                    {
                        userLoginView *uLv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
                        unv = [[UINavigationController alloc] initWithRootViewController:uLv];
                        unv.navigationBar.hidden = YES;
                        uLv.delegate = self;
                        [self.navigationController presentViewController:unv animated:YES completion:nil];
                    }
                }
                else if ([cellText isEqualToString:@"联系我们"])
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:400-601-0982"]];
                    });                    
                }
                else if ([cellText isEqualToString:ZXZX_PAGE])
                {
                    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
                    [chatViewManager pushMQChatViewControllerInViewController:self];
                    [[Mixpanel sharedInstance] track:@"首页“在线咨询”点击"];
                }
                else if([cellText isEqualToString:FWLC_PAGE])
                {
//                    serviceHelperViewController *shvc = [[serviceHelperViewController alloc]init];
                    serviceHelperNewViewController *shvc = [[serviceHelperNewViewController alloc] init];
                    [self.UF_ViewController.navigationController pushViewController:shvc animated:YES];
                }
                else if ([cellText isEqualToString:@"检查更新"]){
                    appUpdateViewController *auvc = [[appUpdateViewController alloc] init];
                    [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
                }
                else if ([cellText isEqualToString:@"分享给好友"])
                {
                    appShareViewController *auvc = [[appShareViewController alloc] init];
                    [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
                }
                else if ([cellText isEqualToString:@"意见反馈"])
                {
                    FeedbackViewController *auvc = [[FeedbackViewController alloc] init];
                    [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
                }
                else
                {
                    firstItemViewController *firstVC = [[firstItemViewController alloc] initWithNibName:@"firstItemViewController" bundle:nil];
                    firstVC.strURL = url;
                    [self.UF_ViewController.navigationController pushViewController:firstVC animated:YES];
                }
            }
            else
                return ;
        }];
    }
    else
    {       
        if(!hasLogin)
        {
            userLoginView *uLv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
            unv = [[UINavigationController alloc] initWithRootViewController:uLv];
            unv.navigationBar.hidden = YES;
            uLv.isReportTap = NO;
            [self.navigationController presentViewController:unv animated:YES completion:nil];
        }
        else
        {
            @try {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhoneNo"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            @catch (NSException *exception)
            {
                [self alertMsgView:exception.reason];
            }
            @finally
            {
                [self alertMsgView:@"您已成功注销"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateToken" object:nil];
            }
        }
    }
}

- (void)alertMsgView:(NSString *)alertMsg
{
    if(alertMsg)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"消息" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ula = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:ula];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

-(void)receivedNotif:(NSNotification *)notification {
    hasLogin = !hasLogin;
    lastUserPhone = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNo"]];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:5 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    if (hasLogin) {
        NSString *phoneNo = [lastUserPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        userLB.text = [NSString stringWithFormat:@"欢迎您，%@",phoneNo];
    }
    else
        userLB.text = @"请先登录";
    [loginBtn setTitle:@"注销" forState:UIControlStateNormal];
}

-(void)loginPushReport:(NSString *)token
{
    reportListViewController *rlvc = [[reportListViewController alloc]init];
    rlvc.token = token;
    [self.UF_ViewController.navigationController pushViewController:rlvc animated:YES];
}

@end
