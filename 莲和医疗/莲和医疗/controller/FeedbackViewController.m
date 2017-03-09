//
//  FeedbackViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2017/3/6.
//  Copyright © 2017年 莲和医疗. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
{
    UITextView *bugQuestTV;
    UITextField *contectTF;
    UILabel *placeLB;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助与反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    bugQuestTV = [[UITextView alloc] initWithFrame:CGRectMake(25  *SCREEN_WEIGHT/375,
                                                              98  *SCREEN_HEIGHT/667,
                                                              326 *SCREEN_WEIGHT/375,
                                                              97  *SCREEN_HEIGHT/667)];
    bugQuestTV.layer.borderWidth = 1;
    bugQuestTV.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    bugQuestTV.layer.borderColor = bugQuestTV.textColor.CGColor;
    bugQuestTV.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:14];
    bugQuestTV.delegate = self;
    [self.view addSubview:bugQuestTV];
    
    placeLB = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                        42*SCREEN_HEIGHT/667,
                                                        bugQuestTV.frame.size.width,
                                                        14 *SCREEN_HEIGHT/667)];
    placeLB.text = @"请告诉我们你遇到的问题或想反馈的意见";
    placeLB.textColor = [UIColor colorWithMyNeed:148 green:148 blue:148 alpha:0.6];
    placeLB.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:14];
    placeLB.textAlignment = NSTextAlignmentCenter;
    [bugQuestTV addSubview:placeLB];
    
    contectTF = [[UITextField alloc] initWithFrame:CGRectMake(25  *SCREEN_WEIGHT/375,
                                                              217 *SCREEN_HEIGHT/667,
                                                              247 *SCREEN_WEIGHT/375,
                                                              40  *SCREEN_HEIGHT/667)];
    contectTF.layer.borderWidth = 1;
    contectTF.textColor = bugQuestTV.textColor;
    contectTF.layer.borderColor = contectTF.textColor.CGColor;
    contectTF.textAlignment = NSTextAlignmentCenter;
    contectTF.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:14];
    contectTF.placeholder = @"请填写手机或邮箱（推荐邮箱）";
    [self.view addSubview:contectTF];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sendBtn.frame = CGRectMake(280 *SCREEN_WEIGHT/375,
                               217 *SCREEN_HEIGHT/667 ,
                               71  *SCREEN_WEIGHT/375,
                               40  *SCREEN_HEIGHT/667);
    sendBtn.tintColor = [UIColor whiteColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1]];
    [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTextViewChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)didTextViewChange:(NSNotification *)sender{
    UITextView *textView = (UITextView *)sender.object;
    if (textView.text.length > 0) {
        placeLB.text = @"";
    }
    else
        placeLB.text = @"请告诉我们你遇到的问题或想反馈的意见";
}

- (void)sendBtnAction{
    
    if (contectTF.text.length ==0 || bugQuestTV.text.length == 0) {
        alertMsgView(@"请填写问题和联系方式", self);
        return;
    }
    if (![self checkText:contectTF.text]) {
        return;
    }
    NSString *strUrl = [NSString stringWithFormat:feedBack_URL];
    NSString *post = [NSString stringWithFormat:@"content=%@&contact_way=%@",bugQuestTV.text,contectTF.text];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *requestData = sendRequestWithFullURL(strUrl, post);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!requestData)
            {
                alertMsgView(@"服务器连接失败，请稍后重试或检查网络连接.", self);
                NSLog(@"send order FAILED check");
                return ;
            }
            NSString *reqStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",reqStr);
            
            NSDictionary *requestDic = parseJsonResponse(requestData);
            NSString *resault = JsonValue([requestDic objectForKey:@"ret"],@"NSString");
            if(resault == nil)
            {
                alertMsgView(@"服务器维护中，请稍后重试.", self);
            }
            NSInteger err = [resault integerValue];
            
            if(err != 0)
            {
                alertMsgView([requestDic objectForKey:@"msg"], self);
                return;
            }
            UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"消息" message:@"发送成功，感谢您的反馈" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [aler addAction:action];
            [self presentViewController:aler animated:YES completion:nil];
        });
    });
}

- (BOOL)checkText:(NSString *) contect{
    
    BOOL isPhoneNo = [FeedbackViewController valiMobile:contect];
    BOOL isMail = [self isValidateEmail:contect];
    if (isPhoneNo || isMail) {
        return YES;
    }
    alertMsgView(@"请填写正确的联系方式（手机号或邮箱）", self);
    return NO;
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
