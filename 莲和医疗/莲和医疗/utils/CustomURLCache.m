//
//  CustomURLCache.m
//  LocalCache
//
//  Created by tan on 13-2-12.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "CustomURLCache.h"
#import "Reachability.h"

@interface CustomURLCache(private)

- (NSString *)cacheFolder;
- (NSString *)cacheFilePath:(NSString *)file;
- (NSString *)cacheRequestFileName:(NSString *)requestUrl;
- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl;
- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request;
- (void)deleteCacheFolder;

@end

@implementation CustomURLCache

@synthesize cacheTime = _cacheTime;
@synthesize diskPath = _diskPath;
@synthesize responseDictionary = _responseDictionary;

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime {
    if (self = [self initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
        self.cacheTime = cacheTime;
        if (path)
            self.diskPath = path;
        else
            self.diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        self.responseDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}



- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    
    if ([request.URL.absoluteString containsString:@"mapi.lhgene.cn:8088/m/db/newslist"]) {
        
        NSString *curUrl = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"http://mapi.lhgene.cn:8088/m/db/newslist/" withString:@""];
        NSInteger listId = [curUrl integerValue];
        switch (listId) {
            case 1:
                [[Mixpanel sharedInstance] track:@"基因世界“精准医疗”选项的点击"];
                break;
            case 140:
                [[Mixpanel sharedInstance] track:@"基因世界“行业动态”选项的点击"];
                break;
            case 141:
                [[Mixpanel sharedInstance] track:@"基因世界“科普天地”选项的点击"];
                break;
            case 142:
                [[Mixpanel sharedInstance] track:@"基因世界“名家专栏”选项的点击"];
                break;
            default:
                break;
        }
        return [super cachedResponseForRequest:request];
    }
    
    if (![request.URL.absoluteString containsString:[NSString stringWithFormat:@"http://mapi.lhgene.cn:8088/resources/mobile"]]){
        return [super cachedResponseForRequest:request];
    }
    
    return [self dataFromRequest:request];
}

- (void)removeAllCachedResponses {
    [super removeAllCachedResponses];
    
    [self deleteCacheFolder];
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
    [super removeCachedResponseForRequest:request];
    
    NSString *url = request.URL.absoluteString;
    NSString *fileName = [self cacheRequestFileName:url];
    NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
    NSString *filePath = [self cacheFilePath:fileName];
    NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    [fileManager removeItemAtPath:otherInfoPath error:nil];
}

#pragma mark - custom url cache

- (NSString *)cacheFolder {
    return @"URLCACHE";
}

- (void)deleteCacheFolder {
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}

- (NSString *)cacheFilePath:(NSString *)file {
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        
    } else {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSString stringWithFormat:@"%@/%@", path, file];
}

- (NSString *)cacheRequestFileName:(NSString *)requestUrl {
    return [Util md5Hash:requestUrl];
}

- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl {
    return [Util md5Hash:[NSString stringWithFormat:@"%@-otherInfo", requestUrl]];
}

- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request {
    

    
    NSString *url = request.URL.absoluteString;
    NSString *fileName = [self cacheRequestFileName:url];
    NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
    NSString *filePath = [self cacheFilePath:fileName];
    NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
    NSDate *date = [NSDate date];
    
    //有网清空缓存
    _hostReach = [Reachability reachabilityWithHostname:MAIN_PAGE];
    
    if(_hostReach.isReachable)
    {
//        __block NSCachedURLResponse *cachedResponse = nil;
//        //sendSynchronousRequest请求也要经过NSURLCache
//        id boolExsite = [self.responseDictionary objectForKey:url];
//        if (boolExsite == nil) {
//            [self.responseDictionary setValue:[NSNumber numberWithBool:TRUE] forKey:url];
//            
//            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error)
//             {
//                 if (response && data) {
//                     
//                     [self.responseDictionary removeObjectForKey:url];
//                     
//                     if (error) {
//                         NSLog(@"error : %@", error);
//                         NSLog(@"not cached: %@", request.URL.absoluteString);
//                         cachedResponse = nil;
//                     }
//                     
//                     NSLog(@"cache url --- %@ ",url);
//                     
//                     //save to cache
//                     NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",
//                                           response.MIMEType, @"MIMEType",
//                                           response.textEncodingName, @"textEncodingName", nil];
//                     [dict writeToFile:otherInfoPath atomically:YES];
//                     [data writeToFile:filePath atomically:YES];
//                     
//                     cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
//                 }
//                 
//             }];
//        }
        [self removeCachedResponseForRequest:request];
        
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL expire = false;
        NSDictionary *otherInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
        
        if (self.cacheTime > 0) {
            NSInteger createTime = [[otherInfo objectForKey:@"time"] intValue];
            if (createTime + self.cacheTime < [date timeIntervalSince1970]) {
                expire = true;
            }
        }
        
        if (expire == false) {
            
            NSLog(@"data from cache ...");
            
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL
                                                                MIMEType:[otherInfo objectForKey:@"MIMEType"]
                                                   expectedContentLength:data.length
                                                        textEncodingName:[otherInfo objectForKey:@"textEncodingName"]];
            NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            return cachedResponse;
        } else {
            NSLog(@"cache expire ... ");
            
            [fileManager removeItemAtPath:filePath error:nil];
            [fileManager removeItemAtPath:otherInfoPath error:nil];
        }
    }
    if (![Reachability networkAvailable]) {
        return nil;
    }
    __block NSCachedURLResponse *cachedResponse = nil;
    //sendSynchronousRequest请求也要经过NSURLCache
    id boolExsite = [self.responseDictionary objectForKey:url];
    if (boolExsite == nil) {
        [self.responseDictionary setValue:[NSNumber numberWithBool:TRUE] forKey:url];
  
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error)
        {
            if (response && data) {
                
                [self.responseDictionary removeObjectForKey:url];
                
                if (error) {
                    NSLog(@"error : %@", error);
                    NSLog(@"not cached: %@", request.URL.absoluteString);
                    cachedResponse = nil;
                }
                
                NSLog(@"cache url --- %@ ",url);
                
                //save to cache
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",
                                      response.MIMEType, @"MIMEType",
                                      response.textEncodingName, @"textEncodingName", nil];
                [dict writeToFile:otherInfoPath atomically:YES];
                [data writeToFile:filePath atomically:YES];
                
                cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            }
            
        }];

        return cachedResponse;
        //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        
    }
    return nil;
}


@end
