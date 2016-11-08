//
//  Address.h
//  UFanDrawer
//
//  Created by Zxt3310 on 16/9/29.
//  Copyright © 2016年 zxt. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef Adress_h
#define Adress_h

#define MAIN_PAGE      @"http://ctdna.m3gene.com:81/resources/mobile/index"
#define ZXZX_PAGE      @"https://static.meiqia.com/dist/standalone.html?eid=33791"
#define FAQ_PAGE       @"http://ctdna.m3gene.com:81/m/faq"
#define LJYY_PAGE      @"http://ctdna.m3gene.com:81/m/order"
#define WDJC_PAGE      @"http://ctdna.m3gene.com:81/m/my/report"
#define FWLC_PAGE      @"http://ctdna.m3gene.com:81/m/procedure"
#define LOIGN_PAGE     @""

#define ZXZX_IMAGE     @"iconfont-zaixianzixunicon81889@3x.png"
#define FAQ_IMAGE      @"iconfont-changjianwenti-2@3x.png"
#define LJYY_IMAGE     @"iconfont-wodeyuyue@3x.png"
#define WDJC_IMAGE     @"iconfont-zixunjiluzixun@3x.png"
#define FWLC_IMAGE     @"iconfont-iuchengrenwu@3x.png"
#define LOIGN_IMAGE    @"iconfont-logout@3x.png"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WEIGHT [[UIScreen mainScreen] bounds].size.width

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WEIGHT, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WEIGHT, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif /* Address_h */

//图片名称命名规则： iPhone5及以下 xxx.png  iphone 6 xxx@2x.png  iphone 6plus  xxx@3x.png


#define CLASS_NUMBER @"NSNumber"
#define CLASS_STRING @"NSString"
#define CLASS_DICTIONARY @"NSDictionary"
#define CLASS_ARRAY @"NSArray"

@interface UIFont (custom)

+(UIFont*) app_FontSize:(CGFloat) size;
+(UIFont *)app_FontSizeBold:(CGFloat)size;

@end
@interface UIColor (custom)

+(UIColor *) colorWithMyNeed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
@interface UILabel (custom)

-(instancetype)initWithScreenFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width high:(CGFloat)high;
@end

void setIntObjectForKey(NSInteger value,NSString *key);

void setStringObjectForKey(NSString *value,NSString *key);

NSInteger getIntForKey(NSString *key);

NSString* getStringForKey(NSString* key);

NSString* deviceImageSelect (NSString *imageName);


UIImage* drawImageWithColor(UIColor *startColor,UIColor *midColor, UIColor *endColor, CGRect frame);



//定义自己的cgmake
CG_INLINE CGRect

CGRectMakeWithAutoSize(CGFloat x, CGFloat y, CGFloat width, CGFloat height)

{
    
    
    CGRect rect;
    
    rect.origin.x = SCREEN_WEIGHT * x/375;
    rect.origin.y = SCREEN_HEIGHT * y/667;
    
    rect.size.width = SCREEN_WEIGHT * width/375;
    rect.size.height = SCREEN_HEIGHT *height/667;
    
    return rect;
    
}


//UIImage* imageWithColor(UIColor* startColor,UIColor *endColor , CGRect frame);

//void drawLinearGradient(CGContextRef context,CGPathRef path ,CGColorRef startColor ,CGColorRef endColor)
