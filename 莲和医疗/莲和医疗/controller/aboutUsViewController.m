//
//  aboutUsViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/14.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "aboutUsViewController.h"

@interface aboutUsViewController ()

@end

@implementation aboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImg.image = [UIImage imageNamed:deviceImageSelect(@"aboutus.png")];
    [self.view addSubview:backImg];
    
    UIColor *textColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1];
    
    UILabel *introductionLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(51, 113, 273, 150)];
    introductionLable.text = @"莲和医疗是一家从事基因科技及肿瘤基因检测技术的上市公司。拥有国际领先水平的无创肿瘤基因检测技术及专家团队，致力于高通量基因检测在临床医学与健康服务中的推广和应用。以基因检测向客户输送健康医疗服务，面向企业提供全方位健康问题解决方案；为个人及家庭输送一站式健康管理系统。是国内从事基因检测及健康数据分析的优秀医疗企业。";
    introductionLable.numberOfLines = 0;
    introductionLable.lineBreakMode = NSLineBreakByCharWrapping;
    introductionLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    introductionLable.textColor = textColor;
    [self.view addSubview:introductionLable];
    
    UILabel *techLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(51, 281, 273, 30)];
    techLable.numberOfLines = 0;
    techLable.text = @"莲和医疗，为品质人生保驾护航。";
    techLable.lineBreakMode = NSLineBreakByWordWrapping;
    techLable.font = introductionLable.font;
    techLable.textColor = textColor;
    [self.view addSubview:techLable];
    
    UILabel *ad = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(51, 419, 375, 16)];
    ad.text = @"@微博：莲和医疗。";
    ad.font = techLable.font;
    ad.textColor = textColor;
    [self.view addSubview:ad];
    
    UILabel *connectLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(51, 396, 375, 13)];
    connectLable.text = @"联系我们";
    connectLable.font = ad.font;
    connectLable.textColor = textColor;
    [self.view addSubview:connectLable];
    
    UILabel *telLabel = [[UILabel alloc ]initWithFrame:CGRectMakeWithAutoSize(51, 439, 375, 13)];
    telLabel.font = ad.font;
    telLabel.textColor = textColor;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"TEL：400-601-0982"];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"："].location + 1,[noteStr string].length - 4);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:redRange];
    [telLabel setAttributedText:noteStr];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(telClick:)];
    [telLabel addGestureRecognizer:tap];
    telLabel.userInteractionEnabled = YES;
    [self.view addSubview:telLabel];
    
    
    UILabel *mailLable = [[UILabel alloc ] initWithFrame:CGRectMakeWithAutoSize(51, 457, 375, 13)];
    mailLable.text = @"E-mail：cs@lifehealthcare.com";
    mailLable.font = ad.font;
    mailLable.textColor = textColor;
    [self.view addSubview:mailLable];
    // Do any additional setup after loading the view.
}


- (void)telClick:(UITapGestureRecognizer *)tap
{
    UILabel *lable = (UILabel *)tap.self.view;
    NSString *str = lable.text;
    str = [str substringFromIndex:4];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",str]] options:@{} completionHandler:nil];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",str]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
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
