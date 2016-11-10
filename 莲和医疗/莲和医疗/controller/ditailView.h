//
//  ditailView.h
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/10.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ditailView : UIView



@property UIImage *ditailImg; //步骤图标

@property UILabel *lineLable; //左侧细线

@property BOOL isThisStep;


@property NSString *stepName; //步骤名

@property NSString *ditailText; //内容

@property NSString *reportTime; //时间

@property CGFloat nextPointy; //下一个view的纵坐标

- (void)drawDitail;

@end
