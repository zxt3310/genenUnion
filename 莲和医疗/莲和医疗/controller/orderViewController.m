//
//  orderViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/8.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "orderViewController.h"

@interface orderTextFiled : UITextField

@end

@implementation orderTextFiled

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithMyNeed:197 green:187 blue:234 alpha:1].CGColor;
        self.font = [UIFont app_FontSize:13];
        self.textColor = [UIColor colorWithMyNeed:135.0 green:126.0 blue:188.0 alpha:1];
        self.layer.borderWidth = 1;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.layer.cornerRadius = 5;
        self.layer.shadowOpacity = 0.9;
        self.layer.shadowColor = [UIColor colorWithMyNeed:201 green:193 blue:232 alpha:1].CGColor;
        self.layer.shadowRadius = 5;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.placeholder = @"";
        
        //[self setValue:[UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMakeWithAutoSize(0, 0, 15, 5)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end

@interface orderViewController () <UITextFieldDelegate>
{
    UIImageView *maleImgView;
    
    UIImageView *femaleImgView;
    
    UIImage *selectedImg;
    UIImage *unSelectedImg;
    
    CGRect selectedFrame;
    CGRect unSelectedFrame;
    BOOL isMale;
    
    orderTextFiled *userNameTF;
    orderTextFiled *ageTF;
    orderTextFiled *phoneTF;
    orderTextFiled *orderTimeTF;
    
    NSString *userSex;

}

@end

@implementation orderViewController

@synthesize productId = productId;
@synthesize productName = productName;
@synthesize price = price;

- (instancetype)init
{
    self=[super init];
    if (self) {
        selectedImg = [UIImage imageNamed:deviceImageSelect(@"nvxinganniu.png")];
        unSelectedImg = [UIImage imageNamed:deviceImageSelect(@"oval77.png")];
        userSex = @"0";

        isMale = YES;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = @"预约取样";
    
    //警告
    UILabel *waringlable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(56, 81, 264, 50)];
    //UILabel *waringlable = [[UILabel alloc]initWithScreenFrame:56 y:81 width:264 high:26];
    waringlable.font = [UIFont app_FontSize:11];
    waringlable.textColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1];
    waringlable.numberOfLines = 0;
    waringlable.textAlignment = NSTextAlignmentCenter;
    waringlable.text = @"请填写表单并保证手机号的准确性，采样时收取费用，在此之前我平台不会要求您汇款操作，谨防诈骗。";
    [self.view addSubview:waringlable];
    
    
    //标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(0, 145, 375, 16)]; //initWithScreenFrame:88 y:145 width:198 high:16];
    titleLable.font = [UIFont app_FontSizeBold:18];
    titleLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = productName;
    [self.view addSubview:titleLable];
    
    //价格
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(156, 173, 67, 14)];
    priceLable.font = [UIFont fontWithName:@"STHeitiSC-Light-Bold" size:14];
    priceLable.textColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1];
    priceLable.textAlignment = NSTextAlignmentCenter;
    priceLable.text = price;
    [self.view addSubview:priceLable];
    
    //性别lable
    UILabel *maleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(100, 277, 33, 13)];
    maleLable.text = @"先生";
    maleLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    maleLable.font = [UIFont app_FontSize:13];
    [self.view addSubview:maleLable];
    
    maleImgView = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(135, 274, 17, 17)];
    maleImgView.image = selectedImg;
    maleImgView.userInteractionEnabled = YES;
    [self.view addSubview:maleImgView];
    
    UILabel *femaleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(215, 277, 33, 13)];
    femaleLable.text = @"女士";
    femaleLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    femaleLable.font = [UIFont app_FontSize:13];
    [self.view addSubview:femaleLable];
    
    femaleImgView = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(248, 274, 21, 21)];
    femaleImgView.image = unSelectedImg;
    UITapGestureRecognizer *femaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(femaleClick)];
    [femaleImgView addGestureRecognizer:femaleTap];
    femaleImgView.userInteractionEnabled = YES;
    [self.view addSubview:femaleImgView];
    
    //姓名
    userNameTF = [[orderTextFiled alloc] initWithFrame:CGRectMakeWithAutoSize(68, 214, 240, 35)];
    userNameTF.placeholder = @"姓名";
    [self.view addSubview:userNameTF];
    
    //年龄
    ageTF = [[orderTextFiled alloc]initWithFrame:CGRectMakeWithAutoSize(68, 312, 240, 35)];
    ageTF.placeholder = @"年龄";
    [self.view addSubview:ageTF];
    
    //联系电话
    phoneTF = [[orderTextFiled alloc]initWithFrame:CGRectMakeWithAutoSize(68, 382, 240, 35)];
    phoneTF.placeholder = @"联系电话";
    [self.view addSubview:phoneTF];
    
    //采样时间
    orderTimeTF = [[orderTextFiled alloc]initWithFrame:CGRectMakeWithAutoSize(68, 452, 240, 35)];
    orderTimeTF.placeholder = @"预约采样时间";
    orderTimeTF.delegate = self;
    [self.view addSubview:orderTimeTF];
    
    //预约按钮
    UIButton *orderButton = [[UIButton alloc]initWithFrame:CGRectMakeWithAutoSize(113, 559, 149, 39)];
    [orderButton setTitle:@"立即预约" forState:UIControlStateNormal ];
    orderButton.backgroundColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    orderButton.tintColor = [UIColor whiteColor];
    orderButton.layer.cornerRadius =10;
    [orderButton addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: orderButton];
    

    datePicker = [[UIDatePicker alloc]init];//WithFrame:CGRectMake(0, 400, 375, 267)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:orderTimeTF];datePicker.backgroundColor = [UIColor whiteColor];
    //datePicker.hidden = YES;
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    NSDate *defaultDate = [date dateByAddingTimeInterval:time];
    datePicker.date = defaultDate;
    orderTimeTF.inputView = datePicker;

    //创建工具条
    UIToolbar *toolbar=[[UIToolbar alloc]init];
    //设置工具条的颜色
    toolbar.barTintColor=[UIColor whiteColor];
    //设置工具条的frame
    toolbar.frame=CGRectMakeWithAutoSize(0, 10, 375, 35);
    //给工具条添加按钮
    UIBarButtonItem *item0=[[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(timeBtClick)];
    toolbar.items = @[item0];
    
    orderTimeTF.inputAccessoryView = toolbar;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    datePicker.hidden = NO;
//    return  NO;
    return  YES;
}

- (void)timeBtClick
{
    NSDate *date = datePicker.date; // 获得时间对象
    
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [forMatter stringFromDate:date];
    
    orderTimeTF.text = dateStr;
    
    [orderTimeTF resignFirstResponder];
    
}

- (void)maleClick
{
    
//    maleImgView.image = selectedImg;
//    femaleImgView.image = unSelectedImg;
    return;
}

- (void)femaleClick
{
    if(isMale)
    {
        femaleImgView.frame = CGRectMakeWithAutoSize(135, 274 , 21, 21);
        maleImgView.frame = CGRectMakeWithAutoSize(248, 274, 17, 17);
        userSex = @"1";
        isMale = NO;
    }
    else
    {
        femaleImgView.frame = CGRectMakeWithAutoSize(248, 274, 21, 21);
        maleImgView.frame = CGRectMakeWithAutoSize(135, 274, 17, 17);
        userSex = @"0";
        isMale = YES;
    }
}


- (void)orderClick
{
    NSString *strUrl = [NSString stringWithFormat:orderRequest_RUL];
    NSString *post = [NSString stringWithFormat:@"truename=%@&gender=%@&age=%@&tel=%@&book_date=%@&product=%ld",userNameTF.text,userSex,ageTF.text,phoneTF.text,orderTimeTF.text,(long)productId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *requestData = sendRequestWithFullURL(strUrl, post);
        
        dispatch_async(dispatch_get_main_queue(), ^{
           if(!requestData)
           {
               NSLog(@"send order FAILED check");
               return ;
           }
            NSString *reqStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",reqStr);
            
            NSDictionary *requestDic = parseJsonResponse(requestData);
            NSString *resault = JsonValue([requestDic objectForKey:@"err"],@"NSString");
            NSInteger err = [resault integerValue];
            
            if(err > 0)
            {
                NSString *error = replaceUnicode([requestDic objectForKey:@"errmsg"]);
                alertMsgView(error, self);
                return;
            }
            
            alertMsgView(@"预约成功", self);
            [self.navigationController popViewControllerAnimated:YES];
        });
    
    
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (event.allTouches.count > 1) {
        return;
    }
    
    UITouch *touch = event.allTouches.anyObject;
    if (![touch.view isKindOfClass:[UITextField class]]) {
        [userNameTF resignFirstResponder];
        [ageTF resignFirstResponder];
        [phoneTF resignFirstResponder];
        [orderTimeTF resignFirstResponder];
        [self.view resignFirstResponder];
    }
    
}

@end
