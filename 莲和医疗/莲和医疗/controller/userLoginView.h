//
//  userLoginView.h
//  漫瑞基因
//
//  Created by 张信涛 on 16/10/2.
//  Copyright © 2016年 zxt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+UFanViewController.h"
#import "UFanBasicViewController.h"
#import <UIKit/UIKit.h>
#import "NetUtils.h"
#import "Address.h"
#import "CMCustomViews.h"

@protocol FFGlobalLoginDelegate <NSObject>
-(void)loginPushReport:(NSString *)token;
@end

@interface userLoginView : UIViewController


//- (UIImage *)imageWithColor:(UIColor *)color frame:(UIButton*)button;

@property (strong,nonatomic) IBOutlet UITextField* Tx_PhoneNumber;
@property (strong,nonatomic) IBOutlet UITextField* Tx_Password;
@property (strong,nonatomic) IBOutlet UIButton* Bt_SendMsg;
@property (strong,nonatomic) IBOutlet UIButton* Bt_Login;
@property BOOL isRegisterPage;
@property BOOL isReportTap;

@property (nonatomic,retain) id<FFGlobalLoginDelegate> delegate;
//@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;

@end


