//
//  serviceHelperViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/14.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "serviceHelperViewController.h"

@interface unitView : UIView
@property UIImage *leftImage;
@property NSString *firstLableText;
@property NSString *secendLableText;
@property NSString *thirdLableText;
@property NSString *imgText;
@property CGFloat nextYPoint;
@end

@implementation unitView

- (void)addUnitView{
   
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(52, 51, 68, 68)];
    imageView.image = _leftImage;
    [self addSubview:imageView];
    
    UILabel *imgLable = [[UILabel alloc ]initWithFrame:CGRectMakeWithAutoSize(43, 118, 85, 40)];
    imgLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    imgLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    imgLable.text = _imgText;
    imgLable.numberOfLines = 0;
    imgLable.textAlignment = NSTextAlignmentCenter;
    imgLable.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:imgLable];
    
    UITextField *outLable = [[UITextField alloc ]initWithFrame:CGRectMakeWithAutoSize(175, 39, 166, 112)];
    outLable.enabled = NO;
    outLable.layer.borderColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1].CGColor;
    outLable.layer.borderWidth = 1;
    outLable.layer.cornerRadius = 10;
    [self addSubview:outLable];
    
    UITextField *firstTF = [[UITextField alloc]initWithFrame:CGRectMakeWithAutoSize(10, 13, 158, 13)];
    firstTF.enabled = NO;
    [firstTF setLeftViewMode:UITextFieldViewModeAlways];
    firstTF.leftView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(0, 0, 13, 13)];
    firstTF.leftView.backgroundColor = [UIColor colorWithMyNeed:201 green:193 blue:232 alpha:1];
    firstTF.leftView.layer.cornerRadius = firstTF.leftView.frame.size.width/2;
    firstTF.text = _firstLableText;
    firstTF.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    firstTF.textColor = [UIColor colorWithMyNeed:74 green:74 blue:74 alpha:1];
    [outLable addSubview:firstTF];
    
    UITextField *secondTF = [[UITextField alloc]initWithFrame:CGRectMakeWithAutoSize(10, 51, 158, 13)];
    secondTF.enabled = NO;
    [secondTF setLeftViewMode:UITextFieldViewModeAlways];
    secondTF.leftView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(0, 0, 13, 13)];
    secondTF.leftView.layer.cornerRadius = secondTF.leftView.frame.size.width/2;
    secondTF.leftView.backgroundColor = [UIColor colorWithMyNeed:201 green:193 blue:232 alpha:1];
    secondTF.text = _secendLableText;
    secondTF.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    secondTF.textColor = [UIColor colorWithMyNeed:74 green:74 blue:74 alpha:1];
    [outLable addSubview:secondTF];
    
    UITextField *thirdTF = [[UITextField alloc] initWithFrame:CGRectMakeWithAutoSize(10, 89, 158, 13)];
    thirdTF.enabled = NO;
    [thirdTF setLeftViewMode:UITextFieldViewModeAlways];
    thirdTF.leftView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(0, 0, 13, 13)];
    thirdTF.leftView.layer.cornerRadius = thirdTF.leftView.frame.size.width/2;
    thirdTF.leftView.backgroundColor = [UIColor colorWithMyNeed:201 green:193 blue:232 alpha:1];
    thirdTF.text = _thirdLableText;
    thirdTF.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    thirdTF.textColor = [UIColor colorWithMyNeed:74 green:74 blue:74 alpha:1];
    [outLable addSubview:thirdTF];
    
    _nextYPoint = self.frame.origin.y + self.frame.size.height;
    
}


@end




@interface serviceHelperViewController ()

@end

@implementation serviceHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务流程";
    self.view.backgroundColor = [UIColor whiteColor];
    unitView *firstView = [[unitView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 64, 375, 152)];
    firstView.firstLableText = @"  填写检测同意书和问卷";
    firstView.secendLableText = @"  采集10毫升血液";
    firstView.thirdLableText = @"  送到医学检验所检验";
    firstView.leftImage = [UIImage imageNamed:deviceImageSelect(@"iconCaiji.png")];
    firstView.imgText = @"血液样本采集";
    
    [firstView addUnitView];
    [self.view addSubview:firstView];
    
    
    unitView *secondView = [[unitView alloc] initWithFrame:CGRectMake(0, firstView.nextYPoint, SCREEN_WEIGHT, firstView.frame.size.height)];
    secondView.firstLableText = @"  ctDNA提取";
    secondView.secendLableText = @"  建库及质控";
    secondView.thirdLableText = @"  样本测序";
    secondView.leftImage = [UIImage imageNamed:deviceImageSelect(@"iconLiucheng.png")];
    secondView.imgText = @"ctDNA\r\n实验流程";
    [secondView addUnitView];
    [self.view addSubview:secondView];
    
    unitView *thirdView = [[unitView alloc]initWithFrame:CGRectMake(0, secondView.nextYPoint, SCREEN_WEIGHT, firstView.frame.size.height)];
    thirdView.firstLableText = @"  生物信息学分析";
    thirdView.secendLableText = @"  注释和报告生成";
    thirdView.thirdLableText = @"  资讯解读服务";
    thirdView.imgText = @"结果注释和解读";
    thirdView.leftImage = [UIImage imageNamed:deviceImageSelect(@"iconJiedu.png")];
    [thirdView addUnitView];
    [self.view addSubview:thirdView];
    
    UILabel *underLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(101, 613, 172, 14)];
    underLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    underLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    underLable.text = @"检测周期：只需10个工作日";
    [self.view addSubview:underLable];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
