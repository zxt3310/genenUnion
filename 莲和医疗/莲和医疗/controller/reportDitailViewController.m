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
    UIImageView *complateView = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(318, 0, 60, 60)];
    complateView.image = [UIImage imageNamed:@"千图网-红色的英文印章"];
    complateView.hidden = YES;
    if(_progress == 1)
    {
        complateView.hidden=NO;
    }
    [reportScrollView addSubview:complateView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 163, 375, 1139)];
    backImage.image = [UIImage imageNamed:@"reportDitail"];
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
    UILabel *usernameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(60, 61, 100, 20)];
    usernameLable.font = [UIFont app_FontSize:13];
    usernameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    usernameLable.text = [NSString stringWithFormat:@"姓名：%@",[reportDitailDic objectForKey:@"name"]];
    [reportScrollView addSubview:usernameLable];
    //年龄
    UILabel *ageLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(60, 93, 100, 20)];
    ageLable.font = [UIFont app_FontSize:13];
    ageLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    ageLable.text = [NSString stringWithFormat:@"年龄：%@",[reportDitailDic objectForKey:@"age"]];
    [reportScrollView addSubview: ageLable];
    //性别
    UILabel *sexLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(164, 61, 82, 20)];
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
    
    //带阴影的横线
    UILabel *shadowLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 127*SCREEN_HEIGHT/667, SCREEN_WEIGHT, 1)];
    shadowLine.layer.borderWidth = 1;
    shadowLine.layer.borderColor = [UIColor colorWithMyNeed:235 green:232 blue:250 alpha:1].CGColor;
    shadowLine.layer.shadowOpacity = 1;
    shadowLine.layer.shadowColor = [UIColor colorWithMyNeed:224 green:220 blue:247 alpha:1].CGColor;
    //shadowLine.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowLine.layer.shadowRadius = 4;
    shadowLine.layer.shadowOffset = CGSizeMake(0, 4);
    [reportScrollView addSubview:shadowLine];

    //查看报告按钮
    UIButton *reportBt = [UIButton buttonWithType:UIButtonTypeSystem];
    reportBt.frame = CGRectMakeWithAutoSize(110, 149, 155, 45);
    reportBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    reportBt.tintColor = [UIColor whiteColor];
    reportBt.layer.cornerRadius = 5;
    [reportBt addTarget:self action:@selector(reportBtClick:) forControlEvents:UIControlEventTouchUpInside];
    reportBt.enabled = NO;
    
    [reportBt setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    if(_progress == 1)
    {
        reportBt.enabled = YES;
        [reportBt setBackgroundImage:[UIImage imageNamed:@"anniuend"] forState:UIControlStateNormal];
    }
    [reportScrollView addSubview:reportBt];

    
    //联系电话
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(164, 93, 200, 20)];
    phoneLabel.numberOfLines = 0;
    phoneLabel.font = [UIFont app_FontSize:13];
    phoneLabel.textColor =  [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",[reportDitailDic objectForKey:@"tel"]];
    [reportScrollView addSubview:phoneLabel];
    
    //流程进度
    CGFloat startHeight = (200*SCREEN_HEIGHT/667);
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
        
        if(i == step & _progress < 1)
        {
            View.isThisStep = YES;
            View.reportTime = @"进行中";
        }

        //设置高图标
        View.ditailImg = [UIImage imageNamed:[self selectReportImg:i currentStep:step]];
        
        [View drawDitail];
        startHeight += View.frame.size.height;
        if(i == stepArray.count - 1)
        {
            View.lineLable.hidden = YES;
        }
        if (i > step)
        {
            View.outLable.layer.borderColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1].CGColor;
            View.lightTF.layer.borderColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1].CGColor;
        }
        
         [reportScrollView addSubview:View];
    }
    
    
    CGSize temp = reportScrollView.contentSize;
    temp.height = startHeight + SCREEN_HEIGHT/4.51 - 100;
    reportScrollView.contentSize = temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reportBtClick:(UIButton *)sender
{
    firstItemViewController *fivc = [[firstItemViewController alloc]init];
    fivc.strURL =[NSURL URLWithString:[NSString stringWithFormat:@"http://mapi.lhgene.cn:8088/m/my/report/%@?token=%@",_reportId,_token]];
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
    //imgName = deviceImageSelect(imgName);
    return imgName;
}

@end
