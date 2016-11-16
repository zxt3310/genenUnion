//
//  reportListViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/9.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "reportListViewController.h"

@interface reportListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    
    NSString *reportTime;
    NSString *username;
    NSString *productName;
    
    CGFloat prograss;
    NSString *prograssTag;
    
    LoadingView *loadingView;
    
    NSArray *reportArray;
    
    NSString *t;
    
    UIImageView *noReportImgView;
    UILabel *noReportLable;
    
}
@end

@implementation reportListViewController
@synthesize reportDic = reportDic;


- (instancetype)init
{
    self = [super init];
    
    if(self)
    {

        t = @"138106639991231231234";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的检测";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.tableFooterView.frame = CGRectZero;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
    
    noReportImgView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(166, 179, 44, 55)];
    noReportImgView.image = [UIImage imageNamed:deviceImageSelect(@"病理报告.png")];
    noReportImgView.hidden = YES;
    
    noReportLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(122, 270, 132, 22)];
    noReportLable.text = @"没有检测报告";
    noReportLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:22];
    noReportLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    noReportLable.hidden = YES;
    [self.view addSubview:noReportImgView];
    [self.view addSubview:noReportLable];
    
    
    [self loadRequest];
    //[self.tableView reloadData];
    
    
    //loading 动画
    float topY = 180;
    if ([UIScreen mainScreen].bounds.size.height > 480.0) {
        topY += 40;
    }
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/2.5, topY, 80, 79)];
    loadingView.hidden = YES;
    //[self.view addSubview:loadingView];
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
   // [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return reportArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT/2.668;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifer = [NSString stringWithFormat:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
   
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMakeWithAutoSize(25, 17, 325, 211)];
        
        //时间 tag 2
        UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(14, 12, 150, 18)];
        timeLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
        timeLable.font = [UIFont app_FontSize:16];
        timeLable.tag = 2;
        [backgroundView addSubview:timeLable];
       
        //姓名 tag 3
        UILabel *usernameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(15, 35, 54, 14)];
        usernameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
        usernameLable.font = [UIFont app_FontSize:13];
        usernameLable.tag = 3;
        [backgroundView addSubview:usernameLable];
       
        //产品名称 tag 4
        UILabel *productNameLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(15, 54, 264, 27)];
        productNameLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
        productNameLable.font = [UIFont app_FontSize:24];
        productNameLable.tag = 4;
        [backgroundView addSubview:productNameLable];
       
        //进度条 tag 5
        //进度条底层
        UILabel *underPrograssLb = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(35, 136, 255, 15)];
        underPrograssLb.layer.borderColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1].CGColor;
        underPrograssLb.layer.borderWidth = 1.0;
        underPrograssLb.layer.cornerRadius = 8;
        [backgroundView addSubview:underPrograssLb];
        //进度条上层
        UITextField *abovePrograssLb = [[UITextField alloc] init];
        abovePrograssLb.enabled = NO;
        abovePrograssLb.layer.cornerRadius = 8;
        abovePrograssLb.backgroundColor = [UIColor colorWithMyNeed:162 green:150 blue:203 alpha:1];
        abovePrograssLb.tag = 5;
        [backgroundView addSubview:abovePrograssLb];
        
        //进度指示器 tag 6
        UIImageView *tagView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(40, 111, 55, 20)];
        tagView.image = [UIImage imageNamed:deviceImageSelect(@"rectangle150.png")];
        tagView.tag = 6;
        [backgroundView addSubview:tagView];
        //指示器文字 tag 7
        UILabel *tagLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(3, 2, 48, 12)];
        tagLable.textColor = [UIColor whiteColor];
        tagLable.textAlignment = NSTextAlignmentCenter;
        tagLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        tagLable.tag = 7;
        [tagView addSubview:tagLable];
        
        //报告生成按钮 tag 8
        UIButton *reportBt = [[UIButton alloc] initWithFrame:CGRectMakeWithAutoSize(106, 161, 105, 25)];
        reportBt.tag = 8;
        reportBt.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        reportBt.tintColor = [UIColor whiteColor];
        reportBt.layer.cornerRadius = 5;
        [reportBt addTarget:self action:@selector(reportBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:reportBt];
        
        
        //底层view tag 1
        backgroundView.tag = 1;
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.shadowOpacity = 0.9;
        backgroundView.layer.shadowColor = [UIColor colorWithMyNeed:201 green:193 blue:232 alpha:1].CGColor;
        backgroundView.layer.shadowRadius = 5;
        backgroundView.layer.shadowOffset = CGSizeMake(0, 4);
        [cell.contentView addSubview:backgroundView];
    }
    
    NSDictionary *dic = reportArray[indexPath.row];

    UIView *backView = (UIView *)[cell.contentView viewWithTag:1];

    UILabel *timeLb = (UILabel *)[backView viewWithTag:2];
    timeLb.text = [dic objectForKey:@"report_date"];
    
    UILabel *userNameLb = (UILabel *)[backView viewWithTag:3];
    userNameLb.text = [dic objectForKey:@"client_name"];
    
    UILabel *productNameLb = (UILabel *)[backView viewWithTag:4];
    productNameLb.text = [dic objectForKey:@"product_name"];
    
    UITextField *prograssView = (UITextField *)[backView viewWithTag:5];
    prograss = [[dic objectForKey:@"current_progress"] floatValue];
    prograssView.frame = CGRectMakeWithAutoSize(35, 136, 255 * prograss, 15);
    
    UIImageView *imageView = (UIImageView *)[backView viewWithTag:6];
    UILabel *tagLable = (UILabel *)[imageView viewWithTag:7];
    tagLable.text = [dic objectForKey:@"current_step"];
    tagLable.frame = CGRectMakeWithAutoSize(3, 2, 48 + (tagLable.text.length - 4) * 12, 12);
    imageView.frame = CGRectMakeWithAutoSize(prograssView.frame.origin.x + prograssView.frame.size.width - 20, 111, 55 + (tagLable.text.length - 4) * 12, 20);
    
    
    UIButton *button = (UIButton *)[backView viewWithTag:8];
    if (prograss >= 1) {
        button.enabled = YES;
        [button setTitle:@"查看报告" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    }
    else
    {
        button.enabled = NO;
        [button setTitle:@"报告生成中" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithMyNeed:209 green:209 blue:209 alpha:1];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reportId = [reportArray[indexPath.row] objectForKey:@"report_id"];
    
    [self ditailLoadRequest:reportId];
}

- (void)reportBtClick:(UIButton *)sender
{
    NSIndexPath *myIndex = [self.tableView indexPathForCell:(UITableViewCell *) [[[sender superview] superview] superview]];
    NSDictionary *dic = reportArray[myIndex.row];
    NSString *currentId = [dic objectForKey:@"report_id"];
    
    firstItemViewController *fivc = [[firstItemViewController alloc]init];
    fivc.strURL =[NSURL URLWithString:[NSString stringWithFormat:@"http://mapi.lhgene.cn/m/my/report/%@?token=%@",currentId,_token]];
    [self.navigationController pushViewController:fivc animated:YES];
}

- (void)loadRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",WDJC_REQUEST,_token];
                        
    
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
        reportArray = JsonValue([jsonData objectForKey:@"data"],@"NSArray");
        if(reportArray.count == 0)
        {
            noReportLable.hidden = NO;
            noReportImgView.hidden = NO;
            return;
        }
}

- (void)ditailLoadRequest:(NSString *)reportId
{
    loadingView.hidden = NO;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mapi.lhgene.cn/m/api/report/%@?token=%@",reportId,_token];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSData *response = sendGETRequest(urlStr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (response==nil){
                // [self.hud hide]
                NSLog(@" response is null check net!");
                loadingView.hidden = YES;
                return;
            }
            
            NSString *strResp = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonData = parseJsonResponse(response);
            if (!jsonData)
            {
                loadingView.hidden = YES;
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
                loadingView.hidden = YES;
                return;
            }
            
            NSDictionary *reportDitailDic = JsonValue([jsonData objectForKey:@"data"],CLASS_DICTIONARY);
            if(reportDitailDic.count == 0)
            {
                alertMsgView(@"您尚未有报告", self);
                loadingView.hidden = YES;
                
    
                return;
            }
            else
            {
                loadingView.hidden = YES;
                reportDitailViewController *rdvc = [[reportDitailViewController alloc]init];
                rdvc.reportDitailDic = reportDitailDic;
                [self.navigationController pushViewController:rdvc animated:YES];
                
            }
        
        });
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
