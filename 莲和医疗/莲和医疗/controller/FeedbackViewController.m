//
//  FeedbackViewController.m
//  莲和医疗
//
//  Created by 张信涛 on 2017/3/6.
//  Copyright © 2017年 莲和医疗. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
{
    UITextView *bugQuestTV;
    UITextField *contectTF;
    UILabel *placeLB;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助与反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    bugQuestTV = [[UITextView alloc] initWithFrame:CGRectMake(25 *SCREEN_WEIGHT/375,
                                                              98 *SCREEN_HEIGHT/667,
                                                              326 *SCREEN_WEIGHT/375,
                                                              97 *SCREEN_HEIGHT/667)];
    bugQuestTV.layer.borderWidth = 1;
    bugQuestTV.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    bugQuestTV.layer.borderColor = bugQuestTV.textColor.CGColor;
    bugQuestTV.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:13];
    bugQuestTV.delegate = self;
    [self.view addSubview:bugQuestTV];
    
    placeLB = [[UILabel alloc] initWithFrame:CGRectMake(100 *SCREEN_WEIGHT/375,
                                                        42*SCREEN_HEIGHT/667,
                                                        117 *SCREEN_WEIGHT/375,
                                                        14 *SCREEN_HEIGHT/667)];
    placeLB.text = @"告诉我你遇到的问题";
    placeLB.textColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1];
    placeLB.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:13];
    [bugQuestTV addSubview:placeLB];
    
    contectTF = [[UITextField alloc] initWithFrame:CGRectMake(25 *SCREEN_WEIGHT/375,
                                                              216 *SCREEN_HEIGHT/667,
                                                              247*SCREEN_WEIGHT/375,
                                                              40 *SCREEN_HEIGHT/667)];
    contectTF.layer.borderWidth = 1;
    contectTF.textColor = bugQuestTV.textColor;
    contectTF.layer.borderColor = contectTF.textColor.CGColor;
    contectTF.textAlignment = NSTextAlignmentCenter;
    contectTF.font = [UIFont fontWithName:@"FZXDXJW--GB1-0" size:14];
    contectTF.placeholder = @"请填写联系方式（推荐邮箱）";
    [self.view addSubview:contectTF];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sendBtn.frame = CGRectMake(280 *SCREEN_WEIGHT/375,
                               217 *SCREEN_HEIGHT/667 ,
                               71 *SCREEN_WEIGHT/375,
                               40 *SCREEN_HEIGHT/667);
    sendBtn.tintColor = [UIColor whiteColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1]];
    [self.view addSubview:sendBtn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTextViewChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)didTextViewChange:(NSNotification *)sender{
    UITextView *textView = (UITextView *)sender.object;
    if (textView.text.length > 0) {
        placeLB.text = @"";
    }
    else
        placeLB.text = @"告诉我你遇到的问题";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
