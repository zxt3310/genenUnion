//
//  ditailView.m
//  莲和医疗
//
//  Created by 张信涛 on 2016/11/10.
//  Copyright © 2016年 莲和医疗. All rights reserved.
//

#import "ditailView.h"
#import "Address.h"

@interface UILabel (ContentSize)
 
- (CGSize)contentSize;
 
@end

@implementation UILabel (ContentSize)

//根据文字计算lable高度
- (CGSize)contentSize {
	NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	 paragraphStyle.lineBreakMode = self.lineBreakMode;
	 paragraphStyle.alignment = self.textAlignment;
	 
	 NSDictionary * attributes = @{NSFontAttributeName : self.font,
											 NSParagraphStyleAttributeName : paragraphStyle};
	 
	 CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
															 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
														 attributes:attributes
															 context:nil].size;
	 return contentSize;
}
@end




@implementation ditailView

@synthesize ditailImg = ditailImg;

@synthesize lineLable = lineLable;
@synthesize stepName= stepName;

@synthesize ditailText = ditailText;
@synthesize nextPointy = nextPointy;
@synthesize reportTime;
@synthesize outLable = outLable;
@synthesize lightTF = ligntTF;

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        _isThisStep = NO;
    }
    return self;
}

- (void)drawDitail
{
    
    
    //步骤图标
    UIImageView *detailImageView = [[UIImageView alloc]initWithFrame:CGRectMakeWithAutoSize(38, 0, 30, 30)];
    detailImageView.image = ditailImg;
    [self addSubview:detailImageView];
    
    //时间
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(99, 25, 90, 14)];
    timeLable.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
    timeLable.textColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    timeLable.text = reportTime;
    [self addSubview:timeLable];
    
    CGFloat y = 0;
    if(reportTime.length == 0)
    {
        y = timeLable.frame.size.height;
    }

    
    //高亮标志
    ligntTF = [[UITextField alloc] initWithFrame:CGRectMakeWithAutoSize(110, 47 - y, 19, 25)];
    ligntTF.enabled = NO;
    ligntTF.layer.borderWidth = 1;
    ligntTF.layer.cornerRadius = 10;
    ligntTF.layer.borderColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1].CGColor;
    ligntTF.transform = CGAffineTransformMakeRotation(M_PI/1);
    if(_isThisStep)
    {
        ligntTF.backgroundColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1];
    }
    [self addSubview:ligntTF];
    
    //文本外框
    outLable = [[UITextField alloc] initWithFrame:CGRectMakeWithAutoSize(97, 56, 235, 60)];
    outLable.layer.borderColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1].CGColor;
    outLable.backgroundColor = [UIColor whiteColor];
    outLable.layer.borderWidth = 1;
    outLable.layer.cornerRadius = 10;
    outLable.enabled = NO;
    
    //内容
    UILabel *textLable = [[UILabel alloc]initWithFrame:CGRectMakeWithAutoSize(22, 28, 198, 26)];
    textLable.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:13];
    textLable.textColor = [UIColor colorWithMyNeed:118 green:118 blue:118 alpha:1];
    textLable.text = ditailText;
    textLable.lineBreakMode = NSLineBreakByWordWrapping;
    textLable.numberOfLines = 0;
    [self bringSubviewToFront:textLable];
    
    [textLable setFrame: CGRectMakeWithAutoSize(22, 28, 198, [textLable contentSize].height)];
    [outLable setFrame:CGRectMakeWithAutoSize(97, 56 - y, 235, [textLable contentSize].height + 39)];
    
    [outLable addSubview:textLable];
    
    [self addSubview:outLable];
    
    //步骤名称
    UILabel *stepNameLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(22, 10, 98, 14)];
    stepNameLable.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
    stepNameLable.textColor = [UIColor colorWithMyNeed:74 green:74 blue:74 alpha:1];
    stepNameLable.text = stepName;
    [outLable addSubview:stepNameLable];
    
    //重新计算高度
    
    self.frame = CGRectMake(0, self.frame.origin.y, 375, textLable.frame.size.height + SCREEN_HEIGHT/5.7);
    
    //下一个view的纵坐标
    nextPointy = self.frame.origin.y + self.frame.size.height;
    
    //左侧细线
    lineLable = [[UILabel alloc] initWithFrame:CGRectMakeWithAutoSize(52, 30, 1, self.frame.size.height - 30)];
    lineLable.layer.borderWidth = 1;
    lineLable.layer.borderColor = [UIColor colorWithMyNeed:135 green:126 blue:188 alpha:1].CGColor;
    lineLable.transform = CGAffineTransformMakeRotation(M_PI/1);
    [self addSubview:lineLable];
    
    
}



@end
