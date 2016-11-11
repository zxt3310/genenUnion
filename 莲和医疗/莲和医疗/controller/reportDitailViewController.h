//
//  reportDitailViewController.h
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/10.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "UFanViewController.h"
#import "ditailView.h"
#import "NetUtils.h"
@interface reportDitailViewController : UFanViewController

{
    ditailView *View;
    
    NSString *titleName;
    NSString *username;
    NSString *age;
    NSString *sex;
    NSString *phone;
    CGFloat numberOfRows;
    NSString *context;
    
}

@property NSString *reportId;

@property NSDictionary *reportDitailDic;

@end

/*

 {
 "ret": 1,
 "data": {
 "name": "张乐园",
 "age": "127",
 "gender": "0",
 "tel": "13810663999",
 "product_name": null,
 "current_step": 7,
 "current_progress": 0.88,
 "steps": [
 {
 "name": "抽血",
 "desc": "描述信息",
 "time": "2016-09-13"
 },
 {
 "name": "样本签收",
 "desc": "描述信息",
 "time": "2016-09-13"
 },
 {
 "name": "分离",
 "desc": "描述信息",
 "time": "2016-09-13"
 },
 {
 "name": "提取",
 "desc": "描述信息",
 "time": "2016-09-13"
 },
 {
 "name": "扩增建库",
 "desc": "描述信息",
 "time": "2016-09-14"
 },
 {
 "name": "高通测序",
 "desc": "描述信息",
 "time": "2016-09-19"
 },
 {
 "name": "生物信息学分析",
 "desc": "描述信息",
 "time": "2016-09-22"
 },
 {
 "name": "出报告",
 "desc": "描述信息",
 "time": ""
 }
 ]
 }
 }
 
*/
