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
    introductionLable.text = @"莲和（北京）医疗科技有限公司是香港上市公司Tack Fiori International Group Limited(HKSECode: 0928)下属境内全资子公司，是一家从事基因检测及健康大数据分析的生物技术公司，公司致力于高通量基因检测在临床医学与健康服务中的推广及应用，拥有国际领先水平的无创肿瘤基因检测技术，为医疗与健康管理机构提供一站式、全方位服务和系统解决方案。";
    introductionLable.numberOfLines = 0;
    introductionLable.lineBreakMode = NSLineBreakByCharWrapping;
    introductionLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    introductionLable.textColor = textColor;
    [self.view addSubview:introductionLable];
    
    UILabel *techLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(51, 281, 273, 40)];
    techLable.numberOfLines = 2;
    techLable.text = @"拥有国际领先水平的无创肿瘤基因检测技术，专业的数据分析团队。";
    techLable.lineBreakMode = NSLineBreakByCharWrapping;
    techLable.font = introductionLable.font;
    techLable.textColor = textColor;
    [self.view addSubview:techLable];
    
    UILabel *ad = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(51, 333.8, 234, 16)];
    ad.text = @"莲和健康，为您守护自己和家人的健康。";
    ad.font = techLable.font;
    ad.textColor = textColor;
    [self.view addSubview:ad];
    
    UILabel *connectLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(51, 396, 52, 13)];
    connectLable.text = @"联系我们";
    connectLable.font = ad.font;
    connectLable.textColor = textColor;
    [self.view addSubview:connectLable];
    
    UILabel *telLabel = [[UILabel alloc ]initWithFrame:CGRectMakeWithAutoSize(51, 419, 140, 13)];
    telLabel.font = ad.font;
    telLabel.textColor = textColor;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"电话：400-601-0982"];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"："].location + 1,[noteStr string].length - 3);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:redRange];
    [telLabel setAttributedText:noteStr];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(telClick:)];
    [telLabel addGestureRecognizer:tap];
    telLabel.userInteractionEnabled = YES;
    [self.view addSubview:telLabel];
    
    
    UILabel *mailLable = [[UILabel alloc ] initWithFrame:CGRectMakeWithAutoSize(51, 437, 185, 13)];
    mailLable.text = @"邮箱：cs@lifehealthcare.com";
    mailLable.font = ad.font;
    mailLable.textColor = textColor;
    [self.view addSubview:mailLable];
    // Do any additional setup after loading the view.
}


- (void)telClick:(UITapGestureRecognizer *)tap
{
    UILabel *lable = (UILabel *)tap.self.view;
    NSString *str = lable.text;
    str = [str substringFromIndex:3];
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
