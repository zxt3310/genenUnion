//
//  NetUtils.m
//  CureMe
//
//  Created by Tim on 12-8-15.
//  Copyright (c) 2012年 Tim. All rights reserved.
//


#import "NetUtils.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"

#define USER_UNIQUE_ID @"token"
#define NTF_NetNotReachable @"N_netNotReachable"

// 同步请求统一函数
// 默认所有调用此函数的请求，都发送至 medapp.ranknowcn.com/api/m.php
NSData *sendRequest(NSString *phpFile, NSString *post)
{
    NSString *finalPost = [[NSString alloc] initWithFormat:@"%@&version=2.2&deviceid=%@&appid=3&source=apple", post, [[NSUserDefaults standardUserDefaults] objectForKey:USER_UNIQUE_ID]];
    NSLog(@"sendRequest: %@", finalPost);
    
    NSDictionary *additionalHeader = nil;
    return sendRequestWithHeaderAndResponse(phpFile, finalPost, additionalHeader, true, false);
}

NSData *sendRequestWithFullURL(NSString *fullURL, NSString *post)
{
    //NSString *finalPost = [NSString stringWithFormat:@"%@&version=2.2&deviceid=%@&appid=3&source=apple", post, [[NSUserDefaults standardUserDefaults] objectForKey:USER_UNIQUE_ID]];
    NSString *finalPost = post;
    NSLog(@"sendRequestWithFullURL:%@ post:%@", fullURL, finalPost);
    
    return sendFullRequest(fullURL, finalPost, nil, true, false);
}
/*
NSData *sendRequestWithFullURL22(NSString *fullURL, NSString *post)
{
    NSString *finalPost = [NSString stringWithFormat:@"%@&version=2.2&deviceid=%@&appid=3&source=apple", post, [[NSUserDefaults standardUserDefaults] objectForKey:USER_UNIQUE_ID]];
    NSLog(@"sendRequestWithFullURL:%@ post:%@", fullURL, finalPost);
    
    return sendFullRequest(fullURL, finalPost, nil, true, false);
}*/

NSData *sendRequestWithFullURLNAP(NSString *fullURL, NSMutableDictionary *respDict)
{
    NSLog(@"sendRequestWithFullURLNAP:%@", fullURL);
    NSDictionary *additionalHeader = nil;
    additionalHeader = [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"appid", nil];
    
    return sendGetReqWithHeaderAndRespDict(fullURL, additionalHeader, respDict, false);
}

NSData *sendRequestWithCookie(NSString *phpFile, NSString *post, NSString *cookie, bool saveSetCookie) {
    NSString *finalPost = [[NSString alloc] initWithFormat:@"%@&version=2.2&deviceid=%@&appid=3&source=apple", post, [[NSUserDefaults standardUserDefaults] objectForKey:USER_UNIQUE_ID]];
    NSLog(@"sendRequest: %@", finalPost);
    
    NSDictionary *additionalHeader = nil;
    if (cookie && [cookie length] > 0) {
        additionalHeader = [NSDictionary dictionaryWithObjectsAndKeys:cookie, @"Cookie", nil];
    }
    NSData *respData = sendRequestWithHeaderAndResponse(phpFile, finalPost, additionalHeader, true, saveSetCookie);
    
    return respData;
}

NSData *sendFullRequest(NSString *fullURL, NSString *post, NSDictionary *additionalHeaders, bool needDispNetState, bool saveSetCookie)
{
    if (needDispNetState) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    NSData *data = nil;
    NSString *postLength = nil;
    NSURLResponse *response = nil;
    NSData *returnData = nil;
    NSHTTPURLResponse *httpResponse = nil;
    NSString *responseString = nil;
    
    @autoreleasepool {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSData *postData = nil;
        NSString *finalURL = nil;
        postData = data;
        finalURL = fullURL;
        postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        [request setURL:[NSURL URLWithString:finalURL]];
        
        if (additionalHeaders) {
            NSArray *keys = additionalHeaders.allKeys;
            for (NSString *key in keys) {
                NSString *value = [additionalHeaders objectForKey:key];
                NSLog(@"POST add Header: %@ value: %@", key, value);
                [request addValue:value forHTTPHeaderField:key];
            }
        }
        //[request setHTTPMethod:@"POST"];
        //[request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //[request setHTTPBody:postData];
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        httpResponse = (NSHTTPURLResponse *) response;
        if ([httpResponse statusCode] != 200) {
            NSLog(@"Response error: http status %ld", (long)[httpResponse statusCode]);
            responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
        }
        
        if (saveSetCookie) {
            NSDictionary *headers = httpResponse.allHeaderFields;
            NSLog(@"setCookie resp: %@", headers);
            
            NSString *setCookie = [headers objectForKey:@"Set-Cookie"];
            if (setCookie && [setCookie length] > 0) {
                //                [CureMeUtils defaultCureMeUtil].loginCookie = setCookie;
            }
        }
        
        // show in the status bar that network activity is starting
        if (needDispNetState) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }
    
    return returnData;
}

NSData *sendRequestWithData(NSString *url, NSData *data)
{
    if (!data || [data length] <= 0) {
        return nil;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *postLength = nil;
    NSURLResponse *response = nil;
    NSData *returnData = nil;
    NSHTTPURLResponse *httpResponse = nil;
    NSString *responseString = nil;
    
    @autoreleasepool {
        postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *fullURL = [NSString stringWithFormat:@"%@", url];
        [request setURL:[NSURL URLWithString:fullURL]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        httpResponse = (NSHTTPURLResponse *) response;
        if ([httpResponse statusCode] != 200) {
            NSLog(@"Response error: http status %ld", (long)[httpResponse statusCode]);
            responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
        }
        httpResponse = nil;
    }
    
    // show in the status bar that network activity is starting
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return returnData;
}

NSData * sendRequestWithHeaderAndResponse(NSString *phpFile, NSString *post, NSDictionary *additionalHeader, bool needDispNetState, bool saveSetCookie)
{
    Reachability *reachability = [Reachability reachabilityWithHostname:@"new.medapp.ranknowcn.com"];
    
    NSNotification *note = nil;
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"new.medapp.ranknowcn.com host not reachable");
            note = [NSNotification notificationWithName:NTF_NetNotReachable object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:note];
            break;
        default:
            break;
    }
    
    // show in the status bar that network activity is starting
    if (needDispNetState) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    NSData *postData = nil;
    NSString *postLength = nil;
    NSURLResponse *response = nil;
    NSData *returnData = nil;
    NSHTTPURLResponse *httpResponse = nil;
    NSString *responseString = nil;
    
    @autoreleasepool {
        postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *fullURL = [NSString stringWithFormat:@"http://new.medapp.ranknowcn.com/api/%@?rn=%.2f", phpFile, [[[NSDate alloc] init] timeIntervalSince1970]];
        [request setURL:[NSURL URLWithString:fullURL]];
        if (additionalHeader) {
            NSArray *keys = additionalHeader.allKeys;
            for (NSString *key in keys) {
                NSString *value = [additionalHeader objectForKey:key];
                NSLog(@"POST add Header: %@ value: %@", key, value);
                [request addValue:value forHTTPHeaderField:key];
            }
        }
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        httpResponse = (NSHTTPURLResponse *) response;
        if ([httpResponse statusCode] != 200) {
            NSLog(@"Response error: http status %ld", (long)[httpResponse statusCode]);
            responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
        }
        
        if (saveSetCookie) {
            NSDictionary *headers = httpResponse.allHeaderFields;
            NSLog(@"setCookie resp: %@", headers);
            
            NSString *setCookie = [headers objectForKey:@"Set-Cookie"];
            if (setCookie && [setCookie length] > 0) {
              //  [CureMeUtils defaultCureMeUtil].loginCookie = setCookie;
            }
        }
        
        // show in the status bar that network activity is starting
        if (needDispNetState) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }
    
    return returnData;
}


NSData *sendGETRequest(NSString *strUrl)
{
    return sendGetReqWithHeaderAndRespDict(strUrl, nil, nil, false);
}

NSData *sendGetReqWithHeaderAndRespDict(NSString *strUrl, NSDictionary *headers, NSMutableDictionary *respDict, bool needDispNetState)
{
    // show in the status bar that network activity is starting
    if (needDispNetState) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    NSData *data = nil;
    @autoreleasepool {
        @try {
            NSURL* url = [NSURL URLWithString:strUrl];
            NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
            [request setTimeoutInterval:30];
            [request setURL:url];
            [request setHTTPMethod:@"GET"];
            if (headers) {
                NSArray *keys = headers.allKeys;
                for (NSString *key in keys) {
                    NSString *value = [headers objectForKey:key];
                    NSLog(@"GET and header: %@ value: %@", key, value);
                    [request addValue:value forHTTPHeaderField:key];
                }
            }
            
            NSHTTPURLResponse *response = nil;
            NSError *error = nil;
            //            NSLog(@"sendGetReqWithHeaderAndRespDict request: %@", request);
            data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
            if (!data) {
                NSLog(@"sendSynchronousRequest fail with error: %@", error);
            }
            
            if (respDict) {
                NSArray *keys = response.allHeaderFields.allKeys;
                for (NSString *key in keys) {
                    [respDict setObject:[response.allHeaderFields objectForKey:key] forKey:key];
                }
            }
            
            response = nil;
            
            // show in the status bar that network activity is starting
            if (needDispNetState) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"sendGetReqWithHeaderAndRespDict exception: %@", exception);
        }
        @finally {
        }
    }
    
    return data;
}


#pragma mark Json parse methods
NSDictionary *parseJsonString(NSString *str)
{
    if (!str || str.length <= 0)
        return nil;
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
}

NSDictionary *parseJsonResponse(NSData *response)
{
    if (!response)
        return nil;
    
    if ([response length] <= 0) {
        return nil;
    }

   
    
    NSError *error = nil;
    return [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
}

/*
NSDictionary *parseJsonString(NSString *str)
{
    if (!str || str.length <= 0)
        return nil;
    
    JSONDecoder *decoder = [CureMeUtils defaultCureMeUtil].jsonDecoder;
    
    NSMutableDictionary *parseResult = nil;
    
    NSError *error = nil;
    parseResult = [decoder objectWithUTF8String:(const unsigned char*)[str UTF8String] length:[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding] error:&error];
    
    //    NSLog(@"JsonData %@ from string: %@", parseResult, str);
    
    return parseResult;
}

NSDictionary *parseJsonResponse(NSData *response)
{
    if (!response)
        return nil;
    
    JSONDecoder *decoder = [CureMeUtils defaultCureMeUtil].jsonDecoder;
    
    NSMutableDictionary *parseResult = nil;
    if ([response length] <= 0) {
        return parseResult;
    }
    
    parseResult = [decoder objectWithData:response];
    
    return parseResult;
}
*/
/*
void updateIOSPushInfo()
{
    NSString *pushToken = [[NSUserDefaults standardUserDefaults] objectForKey:PUSH_TOKEN];
    NSString *uniID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UNIQUE_ID];
    
    if (!uniID || !pushToken)
        return;
    
    NSString *post = [[NSString alloc] initWithFormat:@"action=updiospush&userid=%ld&token=%@", (long)[[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] integerValue], pushToken];
    NSData *response = sendRequest(@"m.php", post);
    
    NSString *strResp = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"action=updiospush resp: %@", strResp);
    
    NSDictionary *jsonData = parseJsonResponse(response);
    if (!jsonData || jsonData.count <= 0) {
        NSLog(@"action=updiospush json invalid: %@", strResp);
        return;
    }
    
    NSNumber *result = [jsonData objectForKey:@"result"];
    if (!result || result.integerValue != 1) {
        NSString *error = [jsonData objectForKey:@"msg"];
        NSLog(@"action=updiospush result invalid: %@", error);
        return;
    }
}
 */

id JsonValue(id value, NSString *defaultClass)
{
    if (!value) {
        if (!defaultClass || [defaultClass length] <= 0)
            return nil;
        
        return [[NSClassFromString(defaultClass) alloc] init];
    }
    
    if ([value isKindOfClass:[NSNull class]])
        return [[NSClassFromString(defaultClass) alloc] init];
    
    return value;
}

NSDate* convertDateFromString(NSString *sdate, NSString *format)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:sdate];
    return date;
}

NSString* convertStringFromDate(NSDate *date, NSString *format)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

NSString* removeHTML(NSString *html)
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return html;
    /*
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
    }
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    return plainText;*/
}

NSString* urlEncode(NSString *str)
{
    if (!str || str.length==0)
        return @"";
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[str UTF8String];
    NSInteger sourceLen = strlen((const char *)source);
    for (NSInteger i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

NSString* replaceUnicode(NSString *unicodeStr)
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                        mutabilityOption:NSPropertyListImmutable
                                                                  format:NULL
                                                        errorDescription:NULL];
    //NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
