//
//  CustomURLCache.h
//  LocalCache
//
//  Created by tan on 13-2-12.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"
#import "Address.h"
#import "Reachability.h"
@interface CustomURLCache : NSURLCache

@property(nonatomic, assign) NSInteger cacheTime;
@property(nonatomic, retain) NSString *diskPath;
@property(nonatomic, retain) NSMutableDictionary *responseDictionary;
@property(nonatomic, retain) Reachability *hostReach;

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime;

- (NSString *)cacheRequestFileName:(NSString *)requestUrl;
- (NSString *)cacheFilePath:(NSString *)file;
@end
