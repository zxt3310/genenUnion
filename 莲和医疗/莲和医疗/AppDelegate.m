//
//  AppDelegate.m
//  UFanDrawer
//
//  Created by zxt on 15/8/21.
//  Copyright (c) 2015年 zxt. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)Delegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDate *lastTime = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastLoginTIme"];
    if(lastTime)
    {
        NSDate *currentTime = getCurrentDate();
        NSTimeInterval time = [currentTime timeIntervalSinceDate:lastTime];
        
        if (time >(12*60*60)) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhoneNo"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
      }
    
    UIColor *startColor = [UIColor colorWithRed:196.0/255 green:174.0/255 blue:228.0/255 alpha:1];
    UIColor *endColor = [UIColor colorWithRed:135.0/255 green:126.0/255 blue:188.0/255 alpha:1];
    CGRect rect = CGRectMake(0, 0, SCREEN_WEIGHT, 64);

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    mainVC.barColor = [self drawImageWithColor:startColor endColor:endColor rect:rect];
    [mainVC setStrURL:[[NSString alloc] initWithFormat:MAIN_PAGE]];
    // webVC.isMainTabPage = true;

    
    
    
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    leftDrawerViewController *leftVC = [[leftDrawerViewController alloc] init];
    UFanViewController *uFanVC = [[UFanViewController alloc] initWithCenterViewController:mainVC leftDrawerViewController:leftVC];
    uFanVC.showShadow = YES;
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:uFanVC];
    
    
    uFanVC.navigationItem.title = @"和普安";
    [self.rootNavigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"FZXDXJW--GB1-0" size:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //self.rootNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:142.0/255 green:126.0/255 blue:188.0/255 alpha:0];
    
    
    
    //UIImage *image = [UIImage imageNamed:@"Rectangle 28@3x.png"];
    [self.rootNavigationController.navigationBar setBackgroundImage:[self drawImageWithColor:startColor endColor:endColor rect:rect] forBarMetrics:UIBarMetricsDefault];

    self.rootNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [[self window] setRootViewController:self.rootNavigationController];
   
    
    //self.window.rootViewController = uFanVC;
    [self.window makeKeyAndVisible];
    
    sleep(1);
    
    if([self isFirstLauch])
    {
        GuideView *guide = [[GuideView alloc] initWithFrame:self.window.bounds];
        [self.window addSubview:guide];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.mishi.UFanDrawer" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UFanDrawer" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UFanDrawer.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSManagedObjectContextLockingError];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - 判断是不是首次登录或者版本更新
-(BOOL )isFirstLauch{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"kAppVersion"];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:@"kAppVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                      startColor:(CGColorRef)startColor
                      endColor:(CGColorRef)endColor
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[] = { 0.0, 1.0 };
        
        NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
        
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
        
        
        CGRect pathRect = CGPathGetBoundingBox(path);
        
        //具体方向可根据需求修改
        CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
        CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
        
        CGContextSaveGState(context);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        CGContextRestoreGState(context);
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
    }
                      
// 生成一个纯色图片
-(UIImage*) drawImageWithColor:(UIColor*) startColor endColor:(UIColor*)endColor rect:(CGRect) frame
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
        [self drawLinearGradient:gc path:path startColor:startColor.CGColor endColor:endColor.CGColor];

        
        //注意释放CGMutablePathRef
        CGPathRelease(path);
        
        //从Context中获取图像，并显示在界面上
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }

@end





