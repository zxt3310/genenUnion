//
//  reportListViewController.h
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/9.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "UFanViewController.h"
#import "Address.h"
#import "NetUtils.h"
#import "reportDitailViewController.h"

@interface reportListViewController : UFanViewController

@property NSDictionary *reportDic;

@property UITableView *tableView;

@property NSString *token;

@end
