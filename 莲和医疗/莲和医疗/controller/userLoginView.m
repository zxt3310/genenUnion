//
//  userLoginView.m
//  漫瑞基因
//
//  Created by 张信涛 on 16/10/2.
//  Copyright © 2016年 zxt. All rights reserved.
//

#import "userLoginView.h"
@implementation userLoginView

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self setIsRegisterPage:NO];
    }
    return self;
}

-(void)viewDidLoad
{
    //背景图
    UIImage *backGroundImage = [UIImage imageNamed:deviceImageSelect(@"loginBGI.png")];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    backImageView.image = backGroundImage;
    [self.view addSubview:backImageView];
    //将背景图层级沉底
    [self.view sendSubviewToBack:backImageView];

    
    
    //边框
    _Tx_PhoneNumber.layer.borderWidth = 0.5f;
    _Tx_Password.layer.borderWidth = 0.5f;
    _Tx_PhoneNumber.layer.borderColor = _Tx_Password.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //设置圆角
    _Tx_PhoneNumber.layer.cornerRadius = _Tx_Password.layer.cornerRadius = 22;
    //设置默认文本字体
    
    _Tx_PhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZXDXJW--GB1-0" size:13],
                                                                                                              NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _Tx_Password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZXDXJW--GB1-0" size:13],
                                                                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置文本框左侧空白 生成空白view
    _Tx_Password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WEIGHT/7.65,0)];
    _Tx_PhoneNumber.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WEIGHT/7.65,0)];
    //设置view显示 不设置不起效
    _Tx_Password.leftViewMode = UITextFieldViewModeAlways;
    _Tx_PhoneNumber.leftViewMode = UITextFieldViewModeAlways;
    
    //数字键盘
    _Tx_Password.keyboardType = _Tx_PhoneNumber.keyboardType = UIKeyboardTypeDecimalPad;
   
    //登录字样
    UILabel *logLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/2-SCREEN_WEIGHT/7.28, SCREEN_HEIGHT/4.6, SCREEN_WEIGHT/3.64, SCREEN_HEIGHT/14.2)];
    logLable.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:SCREEN_WEIGHT/8.93];
    logLable.text = @"登 录";
    logLable.textAlignment = NSTextAlignmentCenter;
    logLable.textColor = [UIColor whiteColor];
    [self.view addSubview:logLable];
    
    
//    查询字体调用名称
//    NSArray *fontFamilies = [UIFont familyNames];
//    for (int i = 0; i < [fontFamilies count]; i++)
//    {
//        NSString *fontFamily = [fontFamilies objectAtIndex:i];
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
//        NSLog (@"Fonts is %@: %@", fontFamily, fontNames);
//    }
    
    
    //文本框及按钮定位
    self.Tx_PhoneNumber.frame = CGRectMake(SCREEN_WEIGHT/2 - SCREEN_WEIGHT/2.68, SCREEN_HEIGHT/2.44, SCREEN_WEIGHT/1.34, SCREEN_HEIGHT/13.34);
    self.Tx_Password.frame = CGRectMake(SCREEN_WEIGHT/2 - SCREEN_WEIGHT/2.68, SCREEN_HEIGHT/1.94, SCREEN_WEIGHT/2.2, SCREEN_HEIGHT/13.34);
    self.Bt_SendMsg.frame = CGRectMake(SCREEN_WEIGHT/2 - SCREEN_WEIGHT/2.68 + SCREEN_WEIGHT/2.2 + 19, SCREEN_HEIGHT/1.94, SCREEN_WEIGHT/4.04, SCREEN_HEIGHT/13.34);
    self.Bt_Login.frame = CGRectMake(SCREEN_WEIGHT/2 - SCREEN_WEIGHT/2.68 , SCREEN_HEIGHT/1.45, SCREEN_WEIGHT/1.34, SCREEN_HEIGHT/13.34);
    self.Tx_Password.backgroundColor = self.Tx_PhoneNumber.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    //button圆角及颜色
    self.Bt_SendMsg.layer.cornerRadius = 23;
    self.Bt_Login.layer.cornerRadius = 20;
    self.Bt_SendMsg.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    self.Bt_Login.backgroundColor = [UIColor colorWithRed:201.0/255 green:193.0/255 blue:232.0/255 alpha:1];
    self.Bt_SendMsg.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"获取验证码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZXDXJW--GB1-0" size:13],
                                                                                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *image = [UIImage imageNamed:deviceImageSelect(@"dengru.png")];

    [_Bt_Login setImage:image forState:UIControlStateNormal];
    
    //注册按钮
    UIButton *Bt_Register = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/1.18, SCREEN_HEIGHT/20.21, SCREEN_WEIGHT/10.39, SCREEN_HEIGHT/40.47)];
    Bt_Register.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"注册" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZXDXJW--GB1-0" size:14],
                                                                                                             NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [Bt_Register setTitle:@"注册" forState:UIControlStateNormal];
    
    [Bt_Register addTarget:self action:@selector(bt_Register_Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Bt_Register];
    
    //取消按钮
    UIImage *cancelBtImg = [UIImage imageNamed:deviceImageSelect(@"iconBack.png")];
    UIButton *Bt_Cancel = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/25, SCREEN_HEIGHT/21.52 , SCREEN_WEIGHT/20.83 , SCREEN_WEIGHT/20.83 )];
    [Bt_Cancel setImage:cancelBtImg forState:UIControlStateNormal];
    [Bt_Cancel addTarget:self action:@selector(swipeGesture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Bt_Cancel];
    
    //向下轻扫
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown; //向下
    [self.view addGestureRecognizer:swipeGesture];
    
    if(_isRegisterPage)
    {
        Bt_Register.hidden = YES;
        logLable.text = @"注册";
        UIImage *registerImg = [UIImage imageNamed:deviceImageSelect(@"register.png")];
        [_Bt_Login setImage:registerImg forState:UIControlStateNormal];
    }
    
}
	
- (void)swipeGesture:(id)sender
{
    if(!_isRegisterPage)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//注册或登录：http://gzh.gentest.ranknowcn.com/m/api/validation?mobile=xxxxxxxxxxx&code=1234
//{ret:1, is_login:true/false, token:'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'}

- (IBAction)Bt_LoginClick:(id)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlStr = [NSString stringWithFormat:@"http://gzh.gentest.ranknowcn.com/m/api/validation?mobile=%@&code=%@"
                                        ,[_Tx_PhoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""]
                                        ,[_Tx_Password.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
       // NSURL *url = [[NSURL alloc] initWithString:urlStr];
        
        
        NSData *response = sendGETRequest(urlStr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response==nil){
               // [self.hud hide];
                NSLog(@" response is null check net!");
                return;
            }
            
            NSString *strResp = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonData = parseJsonResponse(response);
            if (!jsonData)
            {
               // [self.hud hide];
                return;
            }
            
            NSNumber *result = JsonValue([jsonData objectForKey:@"ret"], CLASS_NUMBER);
            if ([result integerValue] != 1) {
             //   [self.hud hide];
                NSLog(@"listarea result invalid: %@", strResp);
            }
            
            
            NSString *errmsg = JsonValue([jsonData objectForKey:@"errmsg"], CLASS_STRING);
            if (errmsg.length > 0)
            {
                NSString *errmsgInZhcn = replaceUnicode(errmsg);
                NSLog(@"errormesg : %@" , errmsgInZhcn);
                
                [self alertMsgView:@"您输入的手机号或验证码有误"];
                
                return;
            }
            
            NSString *token = JsonValue([jsonData objectForKey:@"token"], CLASS_STRING);
            if(!token)
            {
                NSLog(@"service error : no token");
            }
             NSLog(@"listarea result invalid: %@", strResp);
           // [self setInt:([[_Tx_PhoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""] integerValue]) forKey:@"userPhoneNo"];
            //[self setString:token objctForKey:@"token"];
           
            setIntObjectForKey([[_Tx_PhoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""] integerValue],
                                                                                                              @"userPhoneNo");
            
            setStringObjectForKey(token, @"token");
            
            
            //给侧边栏推送刷新cell的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hasLoginState" object:nil];
             [self dismissViewControllerAnimated:YES completion:nil];
             //[self getStringForKey:@"token"];
            //getStringForKey(@"token");
            return;
        });
    });
    
   }



//请求验证码：http://gzh.gentest.ranknowcn.com/m/api/requestcode?mobile=xxxxxxxxxxx
//{ret:1/0, errmsg:xxx}
- (IBAction)Bt_SendMsgClick:(id)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlStr = [NSString stringWithFormat:@"http://gzh.gentest.ranknowcn.com/m/api/requestcode?mobile=%@"
                            ,[_Tx_PhoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
        // NSURL *url = [[NSURL alloc] initWithString:urlStr];
        
        NSData *response = sendGETRequest(urlStr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response==nil){
                // [self.hud hide];
                NSLog(@" response is null check net!");
                return;
            }
            
            NSString *strResp = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonData = parseJsonResponse(response);
            if (!jsonData)
            {
                // [self.hud hide];
                return;
            }
            
            NSNumber *result = JsonValue([jsonData objectForKey:@"ret"], CLASS_NUMBER);
            if ([result integerValue] != 1) {
                //   [self.hud hide];
                NSLog(@"listarea result invalid: %@", strResp);
            }
            
            
            NSString *errmsg = JsonValue([jsonData objectForKey:@"errmsg"], CLASS_STRING);
            if (errmsg.length > 0)
            {
                NSString *errmsgInZhcn = replaceUnicode(errmsg);
                NSLog(@"errormesg : %@" , errmsgInZhcn);
                
                [self alertMsgView:errmsgInZhcn];
                
                return;
            }
            [self alertMsgView:@"验证码已发送"];
            [self sendMsgButtonChange];
            
        });
    });

}

//弹警告 提示错误
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


//- (void)setInt:(NSInteger)value forKey:(NSString *)key
//{
//    if (!key || [key length] <= 0) {
//        return;
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//- (void)setString:(NSString*)value objctForKey:(NSString *)key
//{
//    if (!key || [key length] <= 0) {
//        return;
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//}
//- (NSInteger)getIntForKey:(NSString *)key
//{
//    if (!key || [key length] <= 0) {
//        return 0;
//    }
//    
//    
//    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
//}
//
//- (NSString *)getStringForKey:(NSString *)key
//{
//    if (!key || [key length] <= 0) {
//        return 0;
//    }
//    
//    
//    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
//}




//touch非textfiled 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (event.allTouches.count > 1) {
        return;
    }
    
    UITouch *touch = event.allTouches.anyObject;
    if (![touch.view isKindOfClass:[UITextField class]]) {
        [_Tx_PhoneNumber resignFirstResponder];
        [_Tx_Password resignFirstResponder];
        [self.view resignFirstResponder];
    }

}


- (void)sendMsgButtonChange
{
    __block int time = 60;
    __block UIButton *verifybutton = _Bt_SendMsg;
    CGRect temp = verifybutton.frame;
    verifybutton.enabled = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
               // verifybutton.backgroundColor = [UIColor colorWithHexString:@"FC740A"];
                verifybutton.frame = temp;
                [verifybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [verifybutton setTitle:@"获取验证码" forState:UIControlStateNormal];
                verifybutton.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //verifybutton.backgroundColor = [UIColor grayColor];
                NSString *strTime = [NSString stringWithFormat:@"(%d)秒",time];
                [verifybutton setTitle:strTime forState:UIControlStateNormal];
               // verifybutton.titleLabel.textColor = [UIColor darkGrayColor];
                [verifybutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            });
            time--;
        }
       
    });
    dispatch_resume(_timer);
    
}

- (void)bt_Register_Action
{
    userLoginView *ulv = [[userLoginView alloc] initWithNibName:@"userloginView" bundle:nil];
    ulv.isRegisterPage = YES;
    [self.navigationController pushViewController:ulv animated:YES];
}



@end
