//
//  reportDitailViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/10.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "reportDitailViewController.h"


@interface reportDitailViewController ()
{
    NSArray *stepArray;
    NSArray *imgNameArray;
}
@end

@implementation reportDitailViewController

@synthesize reportDitailDic = reportDitailDic;

- (instancetype)init
{
    self = [super init];
    if(self)
    {

        imgNameArray = @[CHOUXUE_IMG,YANGBEN_IMG,FENLI_IMG,TIQU_IMG,KUOZENGJIANKU_IMG,GAOTONGCEXU_IMG,SHENGWUFENXI_IMG,CHUBAOGAO_IMG];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"我的检测详情";

    stepArray = [reportDitailDic objectForKey:@"steps"];
    NSString *stepStr = [reportDitailDic objectForKey:@"current_step"];
    NSInteger step = [stepStr integerValue];
    
    
    UIScrollView *reportScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    reportScrollView.contentSize = CGSizeMake(SCREEN_WEIGHT, 1500 * SCREEN_HEIGHT /667);
    reportScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:reportScrollView];
    
    //报告完成指示图
    UIImageView *complateView = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(242, 0, 133, 133)];
    complateView.image = [UIImage imageNamed:deviceImageSelect(@"千图网-红色的英文印章.png")];
    complateView.hidden = YES;
    if(step > stepArray.count +1)
    {
        complateView.hidden=NO;
    }
    [reportScrollView addSubview:complateView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 163, 375, 1300)];
    backImage.image = [UIImage imageNamed:deviceImageSelect(@"reportDitail.png")];
    [reportScrollView addSubview:backImage];
    
    //产品名
    UILabel *productNameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(0, 18, 375, 24)];
    productNameLable.font = [UIFont fontWithName:@"HeiTi SC" size:24];
    productNameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    productNameLable.textAlignment = NSTextAlignmentCenter;
    NSString *text = [reportDitailDic objectForKey:@"product_name"];
    if(text != nil)
    {
        productNameLable.text = text;
    }
    else
    {
        productNameLable.text = @"";
    }
    [reportScrollView addSubview:productNameLable];
    
    //姓名
    UILabel *usernameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(38, 60, 100, 13)];
    usernameLable.font = [UIFont app_FontSize:13];
    usernameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    usernameLable.text = [NSString stringWithFormat:@"姓名：%@",[reportDitailDic objectForKey:@"name"]];
    [reportScrollView addSubview:usernameLable];
    //年龄
    UILabel *ageLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(186, 60, 100, 13)];
    ageLable.font = [UIFont app_FontSize:13];
    ageLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    ageLable.text = [NSString stringWithFormat:@"年龄：%@",[reportDitailDic objectForKey:@"age"]];
    [reportScrollView addSubview: ageLable];
    //性别
    UILabel *sexLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(39, 91, 52, 13)];
    sexLable.font = ageLable.font = [UIFont app_FontSize:13];
    sexLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    NSString *gender = [reportDitailDic objectForKey:@"gender"];
    if([gender isEqualToString:@"0"])
    {
        sexLable.text = [NSString stringWithFormat:@"性别：男"];
    }
    else{
        sexLable.text = [NSString stringWithFormat:@"性别：女"];
    }
    [reportScrollView addSubview:sexLable];
    
    //查看报告按钮
    UIButton *reportBt = [[UIButton alloc] initWithFrame:CGRectMakeWithAutoSize(260, 111, 90, 30)];
    reportBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    reportBt.tintColor = [UIColor whiteColor];
    reportBt.layer.cornerRadius = 5;
    [reportBt addTarget:self action:@selector(reportBtClick:) forControlEvents:UIControlEventTouchUpInside];
    reportBt.enabled = NO;
    [reportBt setTitle:@"报告生成中" forState:UIControlStateNormal];
    reportBt.backgroundColor = [UIColor colorWithMyNeed:209 green:209 blue:209 alpha:1];
    if(step > stepArray.count +1)
    {
        reportBt.enabled = YES;
        reportBt.backgroundColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
        [reportBt setTitle:@"查看报告" forState:UIControlStateNormal];
    }
    [reportScrollView addSubview:reportBt];

    
    //联系电话
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(186, 91, 151, 13)];
    phoneLabel.font = [UIFont app_FontSize:13];
    phoneLabel.textColor =  [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",[reportDitailDic objectForKey:@"tel"]];
    [reportScrollView addSubview:phoneLabel];
    
    //流程进度
    CGFloat startHeight = SCREEN_HEIGHT/4.51;
    for(int i =0;i < stepArray.count; i++)
    {
        NSDictionary *stepDic = stepArray[i];
        
        View = [[ditailView alloc] initWithFrame:CGRectMake(0, startHeight, SCREEN_WEIGHT, 0)];
        //View = [[ditailView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 148, SCREEN_WEIGHT, 0)];
        //View.tag = i + 10 ;
        /*
        if(i > 0)
        {   //设置frame
            ditailView *firstView = (ditailView *)[reportScrollView viewWithTag:i + 10 -1];
            View.frame = CGRectMakeWithAutoSize(0, firstView.nextPointy, SCREEN_WEIGHT, 0);
        }*/
        
        View.stepName = [stepDic objectForKey:@"name"];
        View.ditailText = [stepDic objectForKey:@"desc"];
        View.reportTime = [stepDic objectForKey:@"time"];
        
        if(i == step -1)
        {
            View.isThisStep = YES;
           // if(step < stepArray.count)
            {
                View.reportTime = @"进行中";
            }
        }
       

        //设置高图标
        View.ditailImg = [UIImage imageNamed:[self selectReportImg:i currentStep:step - 1]];
        
        [View drawDitail];
        startHeight += View.frame.size.height;
        if(i == stepArray.count - 1)
        {
            View.lineLable.hidden = YES;
        }
        if (i > step - 1)
        {
            View.outLable.layer.borderColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1].CGColor;
            View.lightTF.layer.borderColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1].CGColor;
        }
        
         [reportScrollView addSubview:View];
    }
    
    
    CGSize temp = reportScrollView.contentSize;
    temp.height = startHeight + SCREEN_HEIGHT/4.51;
    reportScrollView.contentSize = temp;
    

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

- (void)reportBtClick:(UIButton *)sender
{
    firstItemViewController *fivc = [[firstItemViewController alloc]init];
    fivc.strURL =[NSURL URLWithString:[NSString stringWithFormat:@"http://mapi.lhgene.cn/m/my/report/%@?token=%@",_reportId,_token]];
    [self.navigationController pushViewController:fivc animated:YES];
}

//图片选择器  命名规则 已完成图片名+$   正在进行 图片名+&  未完成 图片名+！
- (NSString *)selectReportImg:(NSInteger)index currentStep:(NSInteger)step;
{
    
    NSString *imgName = imgNameArray[index];
    
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    NSMutableString *string = [NSMutableString stringWithString:imgName];
    int n = 0;
    for (int i = 0; i < imgName.length; i++) {
        arry[i] = [imgName substringWithRange:NSMakeRange(i, 1)];
        if([arry[i]  isEqual: @"."])
        {
            n = i;
            break;
        }
    }
    
    if(index < step || step == stepArray.count - 1)
    {
        [string insertString:@"&" atIndex:n];
    }
    else if(index == step & step < stepArray.count - 1)
    {
        [string insertString:@"&" atIndex:n];
    }
    else
    {
        [string insertString:@"!" atIndex:n];
    }
    imgName = [string copy];
    imgName = deviceImageSelect(imgName);
    return imgName;
}

@end
