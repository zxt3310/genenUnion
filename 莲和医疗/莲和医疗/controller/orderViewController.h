//
//  orderViewController.h
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/8.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "NetUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+UFanViewController.h"
@interface orderViewController : UIViewController
{
    UIDatePicker *datePicker;
}
@property NSInteger productId;
@property NSString *price;
@property NSString *productName;

@property UFanViewController *UFanVC;



@end
