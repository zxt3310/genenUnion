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
    self.title = @"我的检测详情";

     stepArray = [reportDitailDic objectForKey:@"steps"];
    
    
    UIScrollView *reportScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    reportScrollView.contentSize = CGSizeMake(SCREEN_WEIGHT, 1500 * SCREEN_HEIGHT /667);
    reportScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:reportScrollView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 163, SCREEN_WEIGHT, 1300)];
    backImage.image = [UIImage imageNamed:deviceImageSelect(@"reportDitail.png")];
    [reportScrollView addSubview:backImage];
    
    //产品名
    UILabel *productNameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(104, 18, 168, 24)];
    productNameLable.font = [UIFont fontWithName:@"HeiTi SC" size:24];
    productNameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    NSString *text = [reportDitailDic objectForKey:@"product_name"];
    if(!text)
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
    
    
    //联系电话
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(186, 91, 151, 13)];
    phoneLabel.font = [UIFont app_FontSize:13];
    phoneLabel.textColor =  [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",[reportDitailDic objectForKey:@"tel"]];
    [reportScrollView addSubview:phoneLabel];
    
    //流程进度
    for(int i =0;i < stepArray.count; i++)
    {
        NSDictionary *stepDic = stepArray[i];
        
        View = [[ditailView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 148, SCREEN_WEIGHT, 0)];
        View.tag = i + 10 ;
        if(i > 0)
        {   //设置frame
            ditailView *firstView = (ditailView *)[reportScrollView viewWithTag:i + 10 -1];
            View.frame = CGRectMakeWithAutoSize(0, firstView.nextPointy, SCREEN_WEIGHT, 0);
        }
        
        View.stepName = [stepDic objectForKey:@"name"];
        View.ditailText = [stepDic objectForKey:@"desc"];
        View.reportTime = [stepDic objectForKey:@"time"];
        NSString *stepStr = [reportDitailDic objectForKey:@"current_step"];
        NSInteger step = [stepStr integerValue];
        if(i == step -1)
        {
            View.isThisStep = YES;
            View.reportTime = @"进行中";
        }

        //设置高图标
        View.ditailImg = [UIImage imageNamed:[self selectReportImg:i currentStep:step - 1]];
        [View drawDitail];
        if(i == stepArray.count - 1)
        {
            View.lineLable.hidden = YES;
        }
        
        
         [reportScrollView addSubview:View];
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
    
    if(index < step)
    {
        [string insertString:@"$" atIndex:n];
    }
    else if(index == step)
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
