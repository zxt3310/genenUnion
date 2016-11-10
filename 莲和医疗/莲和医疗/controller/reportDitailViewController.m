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
    
    [self loadRequest];
     stepArray = [reportDitailDic objectForKey:@"steps"];
    
    
    UIScrollView *reportScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    reportScrollView.contentSize = CGSizeMake(SCREEN_WEIGHT, 1350 * SCREEN_HEIGHT /667);
    reportScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:reportScrollView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMakeWithAutoSize(0, 163, SCREEN_WEIGHT, 1139)];
    backImage.image = [UIImage imageNamed:deviceImageSelect(@"reportDitail.png")];
    [reportScrollView addSubview:backImage];
    
    //产品名
    UILabel *productNameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(104, 18, 168, 24)];
    productNameLable.font = [UIFont fontWithName:@"HeiTi SC" size:24];
    productNameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    productNameLable.text = @"和普安基因测序";//[reportDitailDic objectForKey:@"product_name"];
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
//    ditailView *chouxueView = [[ditailView alloc]initWithFrame:CGRectMakeWithAutoSize(0, 148, SCREEN_WEIGHT,0 )];
//    chouxueView.ditailImg = [UIImage imageNamed:@"iconChouxueCopy2@2x.png"];
//    chouxueView.isThisStep = NO;
//    chouxueView.stepName = @"抽血";
//    chouxueView.ditailText = @"静脉抽取10毫升血液，控温运输到实验室。";
//    chouxueView.reportTime = @"2016-09-10";
//    [chouxueView drawDitail];
//    [reportScrollView addSubview:chouxueView];
//    
//    ditailView *yangbenView = [[ditailView alloc]initWithFrame:CGRectMakeWithAutoSize(0, chouxueView.nextPointy, SCREEN_WEIGHT, 0)];
//    yangbenView.ditailImg = [UIImage imageNamed:@"tiquCopy2@2x.png"];
//    yangbenView.isThisStep = YES;
//    yangbenView.stepName = @"提取";
//    yangbenView.ditailText =
//    yangbenView.reportTime = @"2016-10-05";
//    [yangbenView drawDitail];
//    [reportScrollView addSubview:yangbenView];
//    
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
        View.ditailImg = [UIImage imageNamed:@"tiquCopy2@2x.png"];
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
- (void)loadRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"http://gzh.gentest.ranknowcn.com/m/api/report/70?token=13810663999123123123"];
    
    
    NSData *response = sendGETRequest(urlStr);
    
    if (response==nil){
        // [self.hud hide]
        NSLog(@" response is null check net!");
        return;
    }
    
    NSString *strResp = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonData = parseJsonResponse(response);
    if (!jsonData)
    {
        return;
    }
    
    NSNumber *result = JsonValue([jsonData objectForKey:@"ret"], CLASS_NUMBER);
    if ([result integerValue] != 1) {
        //   [self.hud hide];
        NSLog(@"listarea result invalid: %@", strResp);
    }
    NSString *errmsg = JsonValue([jsonData objectForKey:@"errmsg"], CLASS_STRING);
    if (errmsg.length > 0)
    {
        NSString *errmsgInZhcn = replaceUnicode(errmsg);
        NSLog(@"errormesg : %@" , errmsgInZhcn);
        alertMsgView(errmsgInZhcn, self);
        return;
    }
    
    reportDitailDic = JsonValue([jsonData objectForKey:@"data"],CLASS_DICTIONARY);
    if(reportDitailDic.count == 0)
    {
        alertMsgView(@"您尚未有报告", self);
        return;
    }
}


@end
