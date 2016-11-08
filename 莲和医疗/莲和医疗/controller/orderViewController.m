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
}

@end

@implementation orderViewController

- (instancetype)init
{
    self=[super init];
    if (self) {
        selectedImg = [UIImage imageNamed:deviceImageSelect(@"nvxinganniu.png")];
        unSelectedImg = [UIImage imageNamed:deviceImageSelect(@"oval77.png")];

        isMale = YES;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //警告
    UILabel *waringlable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(56, 81, 264, 26)];
    //UILabel *waringlable = [[UILabel alloc]initWithScreenFrame:56 y:81 width:264 high:26];
    waringlable.font = [UIFont app_FontSize:11];
    waringlable.textColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1];
    waringlable.numberOfLines = 0;
    waringlable.textAlignment = NSTextAlignmentCenter;
    waringlable.text = @"请填写表单并保证手机号的准确性，采样时收取费用，在此之前我平台不会要求您汇款操作，谨防诈骗。";
    [self.view addSubview:waringlable];
    
    //标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(88, 145, 198, 16)]; //initWithScreenFrame:88 y:145 width:198 high:16];
    titleLable.font = [UIFont app_FontSizeBold:18];
    titleLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"和普安无创肿瘤基因检测";
    [self.view addSubview:titleLable];
    
    //价格
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(156, 173, 67, 14)];
    priceLable.font = [UIFont fontWithName:@"STHeitiSC-Light-Bold" size:14];
    priceLable.textColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1];
    priceLable.textAlignment = NSTextAlignmentCenter;
    priceLable.text = @"¥16000";
    [self.view addSubview:priceLable];
    
    //性别lable
    UILabel *maleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(100, 277, 26, 13)];
    maleLable.text = @"先生";
    maleLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    maleLable.font = [UIFont app_FontSize:13];
    [self.view addSubview:maleLable];
    
    maleImgView = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(135, 274, 17, 17)];
    maleImgView.image = selectedImg;
    maleImgView.userInteractionEnabled = YES;
    [self.view addSubview:maleImgView];
    
    UILabel *femaleLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(215, 277, 26, 13)];
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
    userNameTF.placeholder = @"  姓名";
    [self.view addSubview:userNameTF];
    
    //年龄
    ageTF = [[orderTextFiled alloc]initWithFrame:CGRectMakeWithAutoSize(68, 312, 240, 35)];
    ageTF.placeholder = @"  年龄";
    [self.view addSubview:ageTF];
    
    //联系电话
    phoneTF = [[orderTextFiled alloc]initWithFrame:CGRectMakeWithAutoSize(68, 382, 240, 35)];
    phoneTF.placeholder = @"  联系电话";
    [self.view addSubview:phoneTF];
    
    //采样时间
    orderTimeTF = [[orderTextFiled alloc]initWithFrame:CGRectMakeWithAutoSize(68, 452, 240, 35)];
    orderTimeTF.placeholder = @"  预约采样时间";
    [self.view addSubview:orderTimeTF];
    

    
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
        isMale = NO;
    }
    else
    {
        femaleImgView.frame = CGRectMakeWithAutoSize(248, 274, 21, 21);
        maleImgView.frame = CGRectMakeWithAutoSize(135, 274, 17, 17);
        isMale = YES;
    }
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
