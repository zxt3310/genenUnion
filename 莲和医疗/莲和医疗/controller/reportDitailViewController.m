//
//  reportDitailViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/10.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "reportDitailViewController.h"
#import "ditailView.h"

@interface reportDitailViewController ()
{
    NSString *titleName;
    NSString *username;
    NSString *age;
    NSString *sex;
    NSString *phone;
    CGFloat numberOfRows;
    NSString *context;
}
@end

@implementation reportDitailViewController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        titleName = @"和普安基因检测";
        username = @"张三";
        sex = @"男";
        age = @"51";
        phone = @"13813810000";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的检测详情";
    
    UIScrollView *reportScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    reportScrollView.contentSize = CGSizeMake(SCREEN_WEIGHT, 1350 * SCREEN_HEIGHT /667);
    reportScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:reportScrollView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 163, SCREEN_WEIGHT, 1139)];
    backImage.image = [UIImage imageNamed:deviceImageSelect(@"reportDitail.png")];
    [reportScrollView addSubview:backImage];
    
    
    UILabel *productNameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(104, 18, 168, 24)];
    productNameLable.font = [UIFont fontWithName:@"HeiTi SC" size:24];
    productNameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    productNameLable.text = titleName;
    [reportScrollView addSubview:productNameLable];
    
    UILabel *usernameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(38, 60, 65, 13)];
    usernameLable.font = [UIFont app_FontSize:13];
    usernameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    usernameLable.text = [NSString stringWithFormat:@"姓名：%@",username];
    [reportScrollView addSubview:usernameLable];
    
    UILabel *ageLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(186, 60, 55, 13)];
    ageLable.font = [UIFont app_FontSize:13];
    ageLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    ageLable.text = [NSString stringWithFormat:@"年龄：%@",age];
    [reportScrollView addSubview: ageLable];
    
    UILabel *sexLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(39, 91, 52, 13)];
    sexLable.font = ageLable.font = [UIFont app_FontSize:13];
    sexLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    sexLable.text = [NSString stringWithFormat:@"性别：%@",sex];
    [reportScrollView addSubview:sexLable];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(186, 91, 151, 13)];
    phoneLabel.font = [UIFont app_FontSize:13];
    phoneLabel.textColor =  [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",phone];
    [reportScrollView addSubview:phoneLabel];
    
    numberOfRows = context.length/15;
    if(numberOfRows < 1)
    {
        numberOfRows = 1;
    }
    
    ditailView *chouxueView = [[ditailView alloc]initWithFrame:CGRectMakeWithAutoSize(0, 148, SCREEN_WEIGHT,0 )];
    chouxueView.ditailImg = [UIImage imageNamed:@"iconChouxueCopy2@2x.png"];
    chouxueView.isThisStep = NO;
    chouxueView.stepName = @"抽血";
    chouxueView.ditailText = @"静脉抽取10毫升血液，控温运输到实验室。";
    chouxueView.reportTime = @"2016-09-10";
    [chouxueView drawDitail];
    [reportScrollView addSubview:chouxueView];
    
    ditailView *yangbenView = [[ditailView alloc]initWithFrame:CGRectMakeWithAutoSize(0, chouxueView.nextPointy, SCREEN_WEIGHT, 0)];
    yangbenView.ditailImg = [UIImage imageNamed:@"tiquCopy2@2x.png"];
    yangbenView.isThisStep = YES;
    yangbenView.stepName = @"提取";
    yangbenView.ditailText = @"15-30纳克dna分子片段（5小时）（从30-150亿个分子片段中找出有用的100万-300万个分子片段）(1纳克=10-9克）";
    yangbenView.reportTime = @"2016-10-05";
    [yangbenView drawDitail];
    [reportScrollView addSubview:yangbenView];
    
    for(int i =0;i<8;i++)
    {
        ditailView *viw = [ditailView alloc] initWithFrame:CGRectMakeWithAutoSize(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
