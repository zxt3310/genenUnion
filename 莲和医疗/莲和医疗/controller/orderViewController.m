//
//  orderViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/8.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "orderViewController.h"

@interface myDatePicker : UIView

@property UIDatePicker *datePicker;
@property UIDatePicker *timePiker;
@end

@implementation myDatePicker
@synthesize datePicker = datePicker;
@synthesize timePiker = timePiker;

- (instancetype)init
{
    self = [super init];
    if(self)
    {

        self.backgroundColor = [UIColor whiteColor];
        datePicker = [[UIDatePicker alloc]init];
        timePiker = [[UIDatePicker alloc]init];
        self.frame = datePicker.frame;
        CGRect temp = datePicker.frame;
        temp.size.width = SCREEN_WEIGHT *2/3;
        datePicker.frame = temp;
        datePicker.minimumDate = [NSDate date];
        
        timePiker.date  = timePiker.minimumDate = [NSDate dateWithTimeIntervalSinceReferenceDate:3600];
        timePiker.maximumDate = [NSDate dateWithTimeIntervalSinceReferenceDate:(8*60*60)];
        
        temp.origin.x = datePicker.frame.origin.x + datePicker.frame.size.width;
        temp.size.width = SCREEN_WEIGHT/3;
        timePiker.frame = temp;
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        timePiker.datePickerMode = UIDatePickerModeTime;
        timePiker.minuteInterval = 30;
        [self addSubview:datePicker];
        [self addSubview:timePiker];
        
    }
    return self;
}

@end

@interface orderTextFiled : UITextField

@end

@implementation orderTextFiled

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithMyNeed:197 green:187 blue:234 alpha:1].CGColor;
        self.font = [UIFont app_FontSize:14];
        self.textColor = [UIColor colorWithMyNeed:88 green:80 blue:138 alpha:1];
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

@interface orderViewController ()
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
    
    myDatePicker *md;

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
        selectedImg = [UIImage imageNamed:@"nvxinganniu"];
        unSelectedImg = [UIImage imageNamed:@"oval77"];
        userSex = @"0";

        isMale = YES;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = @"预约取样";

    //警告
    UILabel *waringlable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(56, 74, 280, 50)];
    //UILabel *waringlable = [[UILabel alloc]initWithScreenFrame:56 y:81 width:264 high:26];
    waringlable.font = [UIFont app_FontSize:12];
    waringlable.textColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1];
    waringlable.numberOfLines = 0;
    waringlable.userInteractionEnabled = YES;
    waringlable.lineBreakMode = NSLineBreakByWordWrapping;
    waringlable.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [waringlable addGestureRecognizer:tap];
    NSString *titleSt = @"欢迎来到和普安，您可以直接在线预约，也可拨打400-601-0982人工预约，电话预约时间9点到18点";
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:titleSt];
    NSRange redRange = [titleSt rangeOfString:@"400-601-0982"];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:redRange];
    [waringlable setAttributedText:noteStr];

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
    maleLable.font = [UIFont app_FontSize:14];
    [self.view addSubview:maleLable];
    
    maleImgView = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(135, 274, 17, 17)];
    maleImgView.image = selectedImg;
    maleImgView.userInteractionEnabled = YES;
    [self.view addSubview:maleImgView];
    
    UILabel *femaleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(215, 277, 33, 13)];
    femaleLable.text = @"女士";
    femaleLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    femaleLable.font = [UIFont app_FontSize:14];
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
    orderTimeTF.placeholder = @"预约时间9点至16点";
    [self.view addSubview:orderTimeTF];
    
    //预约按钮
    UIButton *orderButton = [[UIButton alloc]initWithFrame:CGRectMakeWithAutoSize(113, 559, 149, 39)];
    [orderButton setTitle:@"立即预约" forState:UIControlStateNormal ];
    orderButton.backgroundColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    orderButton.tintColor = [UIColor whiteColor];
    orderButton.layer.cornerRadius =10;
    [orderButton addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: orderButton];
    
    md = [[myDatePicker alloc]init];

//    datePicker = [[UIDatePicker alloc]init];//WithFrame:CGRectMake(0, 400, 375, 267)];
//    datePicker.datePickerMode = UIDatePickerModeTime;
//    datePicker.backgroundColor = [UIColor whiteColor];
//    //datePicker.hidden = YES;
//    
//    NSDate *date = [NSDate date];
//    datePicker.minimumDate = date;
//    datePicker.date = date;
//    datePicker.minuteInterval = 30;
    orderTimeTF.inputView = md;

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
    
    [[Mixpanel sharedInstance] track:@"进入预约页面"];
}

- (void)tapAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:400-601-0982"]]];
}

- (void)timeBtClick
{
    //NSDate *date = datePicker.date; // 获得时间对象
    
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [forMatter stringFromDate:md.datePicker.date];
    
    [forMatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [forMatter stringFromDate:md.timePiker.date];
    
    orderTimeTF.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
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
               alertMsgView(@"服务器连接失败，请稍后重试或检查网络连接.", self);
               NSLog(@"send order FAILED check");
               return ;
           }
            NSString *reqStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",reqStr);
            
            NSDictionary *requestDic = parseJsonResponse(requestData);
            NSString *resault = JsonValue([requestDic objectForKey:@"err"],@"NSString");
            if(resault == nil)
            {
                alertMsgView(@"服务器维护中，请稍后重试.", self);
            }
            NSInteger err = [resault integerValue];
            
            if(err > 0)
            {
               // NSString *error = replaceUnicode([requestDic objectForKey:@"errmsg"]);
                alertMsgView(@"您已预约过服务，如需变更预约时间请与客服联系，谢谢！", self);
                return;
            }
            
            
            for(id object in self.view.subviews)
            {
                if ([object isKindOfClass:[UITextField class]]) {
                    UITextField *TF = (UITextField *)object;
                    TF.text = nil;
                }
            }
            
            alertMsgView(@"您已预约成功，我们将尽快与您联系。", self);
            
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
       // [self.view resignFirstResponder];
    }
    
}

@end
