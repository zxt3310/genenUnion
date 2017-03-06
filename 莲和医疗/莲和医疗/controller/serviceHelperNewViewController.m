//
//  serviceHelperNewViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2017/3/3.
//  Copyright © 2017年 莲和医疗. All rights reserved.
//

#import "serviceHelperNewViewController.h"

@interface serviceHelperUnitView : UIView
@property (nonatomic,strong) NSString *serviceStep;
@property (nonatomic,strong) NSString *unitTitle;
@property (nonatomic,strong) NSString *unitContext;
@property UILabel *lineLB;
@end

@implementation serviceHelperUnitView
{
    UITextField *stepNumberTF;
    UILabel *unitTitleLB;
    UILabel *unitContextLB;
}
#define page_color [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1]
@synthesize serviceStep = _serviceStep;
@synthesize   unitTitle = _unitTitle;
@synthesize unitContext = _unitContext;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //坐上角标
                            stepNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(29*SCREEN_WEIGHT/375,
                                                                                         0,
                                                                                         24*SCREEN_WEIGHT/375,
                                                                                         24*SCREEN_WEIGHT/375)];
        
            stepNumberTF.backgroundColor = page_color;
         stepNumberTF.layer.cornerRadius = stepNumberTF.frame.size.width/2;
              stepNumberTF.textAlignment = NSTextAlignmentCenter;
                  stepNumberTF.textColor = [UIColor whiteColor];
                    stepNumberTF.enabled = NO;
                       stepNumberTF.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [self addSubview:stepNumberTF];
        //竖线
         _lineLB = [[UILabel alloc] initWithFrame:CGRectMake(stepNumberTF.frame.origin.x + stepNumberTF.frame.size.width/2,
                                                             stepNumberTF.frame.size.height,
                                                             1,
                                                             self.frame.size.height - stepNumberTF.frame.size.height)];
        _lineLB.layer.borderWidth = 1;
        _lineLB.layer.borderColor = page_color.CGColor;
        [self addSubview:_lineLB];
        //右侧外框
        UITextField *outletTF = [[UITextField alloc] initWithFrame:CGRectMake(76*SCREEN_WEIGHT/375,
                                                                              13*SCREEN_HEIGHT/667,
                                                                              270*SCREEN_WEIGHT/375,
                                                                              46*SCREEN_HEIGHT/667)];
        outletTF.layer.borderWidth = 1;
        outletTF.layer.borderColor = page_color.CGColor;
        outletTF.enabled = NO;
        outletTF.layer.cornerRadius = 10;
        [self addSubview:outletTF];
        //右侧步骤标题
        unitTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_WEIGHT/375,
                                                                8*SCREEN_HEIGHT/667,
                                                                90*SCREEN_WEIGHT/375,
                                                                14*SCREEN_HEIGHT/667)];
             unitTitleLB.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14*SCREEN_HEIGHT/667];
        unitTitleLB.textColor = page_color;
        [outletTF addSubview:unitTitleLB];
        
        //右侧内容
        unitContextLB = [[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_WEIGHT/375,
                                                                  25*SCREEN_HEIGHT/667,
                                                                  250*SCREEN_WEIGHT/375,
                                                                  14*SCREEN_HEIGHT/667)];
        unitContextLB.textColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1];
             unitContextLB.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13*SCREEN_HEIGHT/667];
        [outletTF addSubview:unitContextLB];
    }
    return self;
}

- (NSString *)serviceStep{
    return _serviceStep;
}
- (void)setServiceStep:(NSString *)serviceStep{
         _serviceStep = serviceStep;
    stepNumberTF.text = serviceStep;
}
- (NSString *)unitTitle{
    return _unitTitle;
}
- (void)setUnitTitle:(NSString *)unitTitle{
          _unitTitle = unitTitle;
    unitTitleLB.text = unitTitle;
}
- (NSString *)unitContext{
    return _unitContext;
}
- (void)setUnitContext:(NSString *)unitContext{
          _unitContext = unitContext;
    unitContextLB.text = unitContext;
}

@end

@interface serviceHelperNewViewController ()

@end

@implementation serviceHelperNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"服务流程"];
    
    NSArray *titleItem = @[@"预约检测",@"样本采集",@"实验室收样",@"样本分析",@"生成报告",@"报告解读"];
    NSArray *contextItem = @[@"可通过电话或官网官微预约，1对1专人服务",
                             @"按照预约到指定地点采集取样",
                             @"样本恒温快速送达自有医学检验所",
                             @"通过高端设备进行精准分析",
                             @"7-10个工作日出具完整、深度检测报告",
                             @"生物及遗传学专家详尽解读"];
    
                UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(87.5*SCREEN_WEIGHT/375, 97*SCREEN_HEIGHT/667, 200*SCREEN_WEIGHT/375, 50*SCREEN_HEIGHT/667)];
                    titleLb.text = @"专业的技术团队和客服人员\n为您提供最贴心的服务";
           titleLb.textAlignment = NSTextAlignmentCenter;
           titleLb.numberOfLines = 0;
                    titleLb.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16*SCREEN_HEIGHT/667];
               titleLb.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    [self.view addSubview:titleLb];
    
    for (int i=0; i<6; i++) {
        serviceHelperUnitView *unitView = [[serviceHelperUnitView alloc] initWithFrame:CGRectMake(0,
                                                                                                  167*SCREEN_HEIGHT/667 + i*78*SCREEN_HEIGHT/667,
                                                                                                  SCREEN_WEIGHT,
                                                                                                  78*SCREEN_HEIGHT/667)];
        unitView.serviceStep = [NSString stringWithFormat:@"0%d",i+1];
          unitView.unitTitle = titleItem[i];
        unitView.unitContext = contextItem[i];
        
        if (i == 5) {
            unitView.lineLB.hidden = YES;
        }
        [self.view addSubview:unitView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
@end
