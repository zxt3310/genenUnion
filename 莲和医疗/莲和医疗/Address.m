//
//  Address.m
//  漫瑞基因
//
//  Created by Zxt3310 on 16/10/9.
//  Copyright © 2016年 zxt. All rights reserved.
//

#import "Address.h"

@implementation UIFont (custom)

+(UIFont *)app_FontSize:(CGFloat)size
{
    return [UIFont fontWithName:@"FZXDXJW--GB1-0" size:size];
}

+(UIFont *)app_FontSizeBold:(CGFloat)size
{
    return [UIFont fontWithName:@"FZXDXJW--GB1-0-Bold" size:size];
}

@end

@implementation UIColor (custom)

+(UIColor *) colorWithMyNeed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha];
}

@end

@implementation UILabel (custom)

-(instancetype)initWithScreenFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width high:(CGFloat)high
{
    CGRect temp = CGRectMake(SCREEN_WEIGHT*x/375, SCREEN_HEIGHT *y/667, SCREEN_WEIGHT*width/375, SCREEN_HEIGHT*high/667);
    return [self initWithFrame:temp];
}

@end

 void setIntObjectForKey(NSInteger value,NSString *key)
{
    if (!key || [key length] <= 0) {
        return;
    }

    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

 void setStringObjectForKey(NSString *value,NSString *key)
{
    if (!key || [key length] <= 0) {
        return;
    }

    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


 NSInteger getIntForKey(NSString *key)
{
    if (!key || [key length] <= 0) {
        return 0;
    }


    return [[NSUserDefaults standardUserDefaults] integerForKey:key];

}


 NSString* getStringForKey(NSString* key)
{
    if (!key || [key length] <= 0) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


 NSString* deviceImageSelect (NSString *imageName)
{
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    NSMutableString *string = [NSMutableString stringWithString:imageName];
    int n = 0;
    for (int i = 0; i < imageName.length; i++) {
        arry[i] = [imageName substringWithRange:NSMakeRange(i, 1)];
        if([arry[i]  isEqual: @"."])
        {
            n = i;
            break;
        }
    }
    
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
        return imageName;
    }
    else if(IS_IPHONE_6)
    {
       [string insertString:@"@2x" atIndex:n];
    }
    else if(IS_IPHONE_6P)
    {
        [string insertString:@"@3x" atIndex:n];
    }
    else
    {
        return nil;
    }
    
    NSLog(@"loading image %@",string);
    
    return [string copy];
}


void drawLinearGradient(CGContextRef context , CGPathRef path , CGColorRef startColor,CGColorRef midColor ,CGColorRef endColor)
//path:(CGPathRef)path
//startColor:(CGColorRef)startColor
//endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.3,0.6, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id)midColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
//    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
//    横向渐变
//    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
//    纵向渐变
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

// 生成一个纯色图片
UIImage* drawImageWithColor(UIColor *startColor,UIColor *midColor, UIColor *endColor, CGRect frame)
{
    
    //创建CGContextRef
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGRect rect = frame;
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));     //移动到画笔起始点
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));  //划线到指定坐标
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathMoveToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));     //移动到另一起始点
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    //CGPathCloseSubpath(path);                                                  //封闭图形
    
    //绘制渐变
    drawLinearGradient(gc,path,startColor.CGColor,midColor.CGColor,endColor.CGColor);// :gc path:path startColor:startColor.CGColor endColor:endColor.CGColor;
    
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

void alertMsgView(NSString *alertMsg ,UIViewController *uvc)
{
    if(alertMsg)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"消息" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ula = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:ula];
        [uvc presentViewController:alert animated:YES completion:nil];
    }
    
}

NSDate* getCurrentDate()
{
    NSDate *loginDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:loginDate];
    NSDate *currentDate = [loginDate dateByAddingTimeInterval:time];
    return currentDate;
}
