//
//  Address.h
//  UFanDrawer
//
//  Created by Zxt3310 on 16/9/29.
//  Copyright © 2016年 zxt. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <MeiQiaSDK/MQManager.h>
#import "WeiboSDK.h"
#import "Mixpanel.h"

#ifndef Adress_h
#define Adress_h

#define MAIN_PAGE                        @"http://mapi.lhgene.cn/resources/mobile/h5_main/html/index.html"
#define ZXZX_PAGE                        @"https://static.meiqia.com/dist/standalone.html?eid=33791"
#define GYWM_PAGE                        @"http://mapi.lhgene.cn/m/about"
#define LJYY_PAGE                        @"http://ctdna.m3gene.com:81/m/order"
#define WDJC_PAGE                        @"http://mapi.lhgene.cn/m/my/report"
#define FWLC_PAGE                        @"http://mapi.lhgene.cn/m/procedure"
#define LOIGN_PAGE                       @""

#define WDJC_REQUEST                     @"http://mapi.lhgene.cn/m/api/reports"

#define ZXZX_IMAGE                       @"iconfontZaixianzixunicon81889"
#define GYWM_IMAGE                       @"iconfontGuanyuwomen2"
#define LJYY_IMAGE                       @"iconfont-wodeyuyue@3x.png"
#define WDJC_IMAGE                       @"iconfontZixunjiluzixun"
#define FWLC_IMAGE                       @"iconfontIuchengrenwu"
#define LOIGN_IMAGE                      @"iconfontLogout"

#define PRODUCT1_URL                     @"http://mapi.lhgene.cn/m/product/1"
#define PRODUCT2_URL                     @"http://mapi.lhgene.cn/m/product/2"
#define PRODUCT3_URL                     @"http://mapi.lhgene.cn/m/product/3"

#define orderRequest_RUL                 @"http://mapi.lhgene.cn/m/api/order"

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


#define CLASS_NUMBER                      @"NSNumber"
#define CLASS_STRING                      @"NSString"
#define CLASS_DICTIONARY                  @"NSDictionary"
#define CLASS_ARRAY                       @"NSArray"

#define CHOUXUE_IMG                       @"Chouxue.png"
#define YANGBEN_IMG                       @"iconYangben.png"
#define FENLI_IMG                         @"Fenli.png"
#define TIQU_IMG                          @"tiqu.png"
#define KUOZENGJIANKU_IMG                 @"kuozengjianku.png"
#define GAOTONGCEXU_IMG                   @"Gaotong.png"
#define SHENGWUFENXI_IMG                  @"Fenxi.png"
#define CHUBAOGAO_IMG                     @"Chubaogao.png"

#define MIXPANEL_TOKEN                    @"af67f0a0fb4591e37e976e52e83c058a"
//微信分享
#define WeChat_AppId                      @"wx46e3337f9221fdf4"
#define WeChat_AppSecret                  @"45f989118eda1a8d5bc5928a4c1a6ee5"
//QQ 分享
#define QQ_AppId                          @"1106003542"
#define QQ_AppKey                         @"WjNYIaJcQ55v7J1s"
//微博分享
#define WeiBo_AppId                       @"2052926829"
#define WeiBo_AppSecret                   @"9a4475a48accb01dd0a60ebf57be6b23"
//美洽在线咨询 第三方包
#define MQ_App_Key                        @"7fd14f3b45c51ecad67d97f6cc937b03"
#define SEC_Key                           @"$2a$12$xiFz3TgAv.i576UV.88XXObs.dS9s8SBegQhAKPqJLD4uyRLVyqfS"

@interface WeixinBackTools : NSObject <WXApiDelegate>

@end

@interface QQBackTools : NSObject <QQApiInterfaceDelegate>

@end

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

void alertMsgView(NSString *alertMsg ,UIViewController *uvc);

UIImage* drawImageWithColor(UIColor *startColor,UIColor *midColor, UIColor *endColor, CGRect frame);

NSDate* getCurrentDate();

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
