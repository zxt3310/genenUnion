//
//  UFanViewController.m
//  UFanDrawer
//
//  Created by zxt on 15/8/21.
//  Copyright (c) 2015年 zxt. All rights reserved.
//
#define UFSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define UFSCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define UFShadowRadius 10.0f
#define UFShadowOpacity 0.8
#define UFDrawerWidth 375//UFSCREEN_WIDTH/1.3
#define UFDrawerTime 0.18
#define UFDrawerSpeed UFDrawerWidth/UFDrawerTime

#import "UFanViewController.h"

@interface UFanViewController ()<UIGestureRecognizerDelegate>

{
    CGFloat drawer_speed;
    BOOL isShow;
    
    UIColor *starColor;
    UIColor *midColor;
    UIColor *endColor;
    UIImage *leftImage;
}

@property (nonatomic, strong) UIView *coverView;

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController;

- (void)setCenterViewController:(UIViewController *)centerViewController;
- (void)setLeftDrawerViewController:(UIViewController *)leftDrawerViewController;
- (CGRect)setLeftDrawerViewFrame;
- (void)setRightDrawerViewController:(UIViewController *)rightDrawerViewController;

- (void)setUp;
- (void)setUpGestureRecognizers;
- (void)updateShadowOfLeftView:(BOOL)show;

@end

@implementation UFanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    //[self setUpGestureRecognizers];
    //[self setUp];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton .title = @"首页";
    [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
   // [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontSize] forState:<#(UIControlState)#>
    self.navigationItem.backBarButtonItem = backButton ;
    isShow = NO;
    
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    CGPoint point = [touch locationInView:self.centerViewController.view];
    
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        //
        CGRect centerViewContentRect = self.centerViewController.view.frame;
        centerViewContentRect = CGRectIntersection(centerViewContentRect, self.leftDrawerViewController.view.frame);
        return !CGRectContainsPoint(centerViewContentRect, point);
    }else {
        //
        CGRect centerViewContentRect = self.centerViewController.view.frame;
        centerViewContentRect = CGRectIntersection(centerViewContentRect, self.leftDrawerViewController.view.frame);
        return !CGRectContainsPoint(centerViewContentRect, point);
    }
}

#pragma mark - Action

- (void)tapAction{
    [self disMissLeftDrawer];
    isShow = NO;
}

- (void)panAction:(UIPanGestureRecognizer *)panGesture{
    
    [self updateShadowOfLeftView:YES];
    
    CGPoint translatedPoint = [panGesture translationInView:self.centerViewController.view];
    
    if (translatedPoint.x >= UFDrawerWidth) {
        translatedPoint.x = UFDrawerWidth;
    }
    self.leftDrawerViewController.view.transform = CGAffineTransformMakeTranslation(translatedPoint.x, 0);
    self.leftDrawerViewController.view.alpha =.8;
    CGFloat alphaGrade = .6 / UFDrawerWidth;
    self.coverView.alpha = 1;
    self.coverView.backgroundColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:alphaGrade * translatedPoint.x];
    
    //手势停止时停靠
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        CGFloat duration;
        
        if (translatedPoint.x <= UFDrawerWidth && translatedPoint.x >= UFDrawerWidth/2) {
            duration = (UFDrawerWidth - translatedPoint.x) / drawer_speed;
            [UIView animateWithDuration:duration animations:^{
                self.leftDrawerViewController.view.transform = CGAffineTransformMakeTranslation(UFDrawerWidth, 0);
            }];
        }else {
            duration = translatedPoint.x / drawer_speed;
            [UIView animateWithDuration:duration animations:^{
                self.leftDrawerViewController.view.transform = CGAffineTransformIdentity;
                self.coverView.alpha = 0;
            } completion:^(BOOL finished) {
                [self updateShadowOfLeftView:NO];
            }];
        }
        
        self.coverView.backgroundColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:.5];
        isShow = YES;
    }
}

#pragma mark - Private


- (void)setUp{
    drawer_speed = UFDrawerWidth/UFDrawerTime;
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UFSCREEN_WIDTH, UFSCREEN_HEIGHT)];
    //self.coverView.backgroundColor = [UIColor colorWithRed:42/255 green:42/255 blue:42/255 alpha:.1];
    
    self.coverView.alpha = 0;
    [self.centerViewController.view addSubview:self.coverView];
}

- (void)updateShadowOfLeftView:(BOOL)show {

    UIView *leftView = self.leftDrawerViewController.view;
    if (show) {
        leftView.layer.masksToBounds = NO;
        leftView.layer.shadowRadius = UFShadowRadius;
        leftView.layer.shadowOpacity = UFShadowOpacity;
        
        if (leftView.layer.shadowPath == NULL) {
            leftView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:leftView.bounds] CGPath];
        }else {
            CGRect currentPath = CGPathGetBoundingBox(leftView.layer.shadowPath);
            if (CGRectEqualToRect(currentPath, leftView.bounds) == NO) {
                leftView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:leftView.bounds] CGPath];
            }
        }
        
    }else if (leftView.layer.shadowPath != NULL){
        leftView.layer.shadowRadius = .0f;
        leftView.layer.shadowOpacity = .0f;
        leftView.layer.shadowPath = NULL;
        leftView.layer.masksToBounds = YES;
    }
}

-(void)setUpGestureRecognizers{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [tapGes setDelegate:self];
    [self.view addGestureRecognizer:tapGes];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [panGes setDelegate:self];
    [self.view addGestureRecognizer:panGes];
}

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController {
    return [self initWithCenterViewController:centerViewController leftDrawerViewController:leftDrawerViewController rightDrawerViewController:nil];
}

-(void)setCenterViewController:(UIViewController *)centerViewController{
    _centerViewController = centerViewController;
    [self addChildViewController:self.centerViewController];
    //view
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self.centerViewController.view setFrame:self.view.bounds];
    [self.view addSubview:self.centerViewController.view];
    //controller
    [self.centerViewController didMoveToParentViewController:self];
}

-(void)setLeftDrawerViewController:(UIViewController *)leftDrawerViewController{
    _leftDrawerViewController = leftDrawerViewController;
    [self addChildViewController:self.leftDrawerViewController];
    //view
    [self.leftDrawerViewController.view setFrame:[self setLeftDrawerViewFrame]];
    [self.view addSubview:self.leftDrawerViewController.view];
    //controller
    [self.leftDrawerViewController didMoveToParentViewController:self];
}

-(CGRect)setLeftDrawerViewFrame {
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(0,0);//CGPointMake(-UFDrawerWidth, 0);
    frame.size.width = UFSCREEN_WIDTH;//UFDrawerWidth;
    _leftDrawerViewController.view.hidden = YES;
    _leftDrawerViewController.view.alpha = 0;
    return frame;
}

-(void)setRightDrawerViewController:(UIViewController *)rightDrawerViewController{}


#pragma mark - Public
-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController {
    NSParameterAssert(centerViewController);
    NSParameterAssert(leftDrawerViewController);
    if (self = [super init]) {
        
        [self setCenterViewController:centerViewController];
        [self setLeftDrawerViewController:leftDrawerViewController];
        [self setRightDrawerViewController:rightDrawerViewController];
    }
    return self;
}



-(void)closeDrawerAnimtaion:(BOOL)animatied complete:(void (^)(BOOL))completion {
    if (animatied) {
        [self disMissLeftDrawer];
        completion(YES);
    }
}
//按钮弹出侧边栏
-(void)triggerLeftDrawer {
    
    if(isShow)
    {
        [self disMissLeftDrawer];
        isShow = NO;
        return;
    }
    
//    if (self.showShadow) {
//        [self updateShadowOfLeftView:self.showShadow];
//    }
    
    CGAffineTransform t1 = CGAffineTransformMakeScale(1, 1);
    CGAffineTransform t2 = CGAffineTransformMakeScale(0.9, 0.9);
    self.leftDrawerViewController.view.transform = t2;
    [UIView animateWithDuration:UFDrawerTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //
//        self.coverView.alpha = 1;
//        //self.leftDrawerViewController.view.backgroundColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:1];
//        self.leftDrawerViewController.view.alpha = .8;
//        self.coverView.backgroundColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:.5];
//        self.leftDrawerViewController.view.transform = CGAffineTransformMakeTranslation(UFDrawerWidth, 0);
        self.leftDrawerViewController.view.hidden = NO;
        self.leftDrawerViewController.view.alpha = 0.93;
        self.leftDrawerViewController.view.transform = t1;
    } completion:^(BOOL finished) {
        //
    }];
    isShow = YES;
}

-(void)disMissLeftDrawer {
    CGAffineTransform t2 = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:UFDrawerTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //
        //self.leftDrawerViewController.view.transform = CGAffineTransformIdentity;
        self.leftDrawerViewController.view.alpha = 0;
        self.leftDrawerViewController.view.transform = t2;
    } completion:^(BOOL finished) {
        //
        self.leftDrawerViewController.view.hidden = YES;
        if (self.showShadow) {
            [self updateShadowOfLeftView:NO];
        }
        self.coverView.alpha = 0;
        isShow = NO;
    }];
}

- (void)sethasLogin:(BOOL)hasLogin1
{
    hasLogin = hasLogin1;
}

- (BOOL)gethasLogin
{
    return hasLogin;
}



@end
