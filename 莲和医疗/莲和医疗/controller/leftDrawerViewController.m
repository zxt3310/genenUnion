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
}
//@property (nonatomic, strong) UITableView *tableView;

@end

@implementation leftDrawerViewController

-(void)loadView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.tableView.scrollEnabled = NO;
    self.view = self.tableView;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];  
    
    self.view.backgroundColor = [UIColor grayColor];
    self.items = @[@"",WDJC_PAGE,ZXZX_PAGE,FWLC_PAGE,GYWM_PAGE,LOIGN_PAGE];
    self.itemsMenu = @[@"",@"我的检测",@"在线咨询",@"服务流程",@"关于我们",@"登        录"];
    self.itemsImageName =@[@"",WDJC_IMAGE,ZXZX_IMAGE,FWLC_IMAGE,GYWM_IMAGE,LOIGN_IMAGE];
    // Do any additional setup after loading the view.
    
    userLoginView *uLv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
    unv = [[UINavigationController alloc] initWithRootViewController:uLv];
    unv.navigationBar.hidden = YES;

    
    hasLogin = NO;
    lastUserPhone =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNo"];
    lastToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (lastToken !=nil & lastUserPhone !=nil)
    {
        hasLogin = YES;
    }

    starColor = [UIColor colorWithRed:114.0/255 green:97.0/255 blue:179.0/255 alpha:1];
    midColor =  [UIColor colorWithRed:140.0/255 green:121.0/255 blue:214.0/255 alpha:1];
    endColor = [UIColor whiteColor];
    
    UIImage *leftImage = drawImageWithColor(starColor, midColor, endColor, self.view.frame);
    self.view.backgroundColor = [UIColor colorWithPatternImage:leftImage];
    
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/5.14, SCREEN_HEIGHT/1.29, SCREEN_WEIGHT/3.21, SCREEN_HEIGHT/6.67)];
    
    logoImage.image = [UIImage imageNamed:deviceImageSelect(@"101.png")];
    
    [self.tableView addSubview:logoImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotif:) name:@"ReloadView" object:nil];
    
}

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
//        UIFont *myFont = [UIFont fontWithName: @"Arial" size: 25.0 ];
//        cell.textLabel.font  = myFont;
//        cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/40, SCREEN_HEIGHT/18, SCREEN_HEIGHT/8, SCREEN_HEIGHT/8)];
//        cell.textLabel.textAlignment = NSTextAlignmentRight;
          cell.userInteractionEnabled = NO;
      }
//    else
    
    
    cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/5, SCREEN_HEIGHT/31, SCREEN_HEIGHT/31.76, SCREEN_HEIGHT/31.76)];   //侧边栏图标
    
    cellImageView.image =[UIImage imageNamed:deviceImageSelect(self.itemsImageName[indexPath.row])];
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
//                else if ([cellText isEqualToString:GYWM_PAGE])
//                {
//                    aboutUsViewController *auvc = [[aboutUsViewController alloc]init];
//                    [self.UF_ViewController.navigationController pushViewController:auvc animated:YES];
//                    
//                }
                else if([cellText isEqualToString:FWLC_PAGE])
                {
                    serviceHelperViewController *shvc = [[serviceHelperViewController alloc]init];
                    [self.UF_ViewController.navigationController pushViewController:shvc animated:YES];
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
        UIAlertAction *ula = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:ula];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

-(void)receivedNotif:(NSNotification *)notification {
    hasLogin = !hasLogin;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:5 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)loginPushReport:(NSString *)token
{
    reportListViewController *rlvc = [[reportListViewController alloc]init];
    rlvc.token = token;
    [self.UF_ViewController.navigationController pushViewController:rlvc animated:YES];
}

@end
