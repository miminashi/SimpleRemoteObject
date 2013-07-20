//
//  SRSimpleRESTRemoteObject.m
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/11.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "SRSimpleRESTRemoteObject.h"

#import <objc/runtime.h>
#import <Foundation/NSObject.h>

@implementation SRSimpleRESTRemoteObject

+ (NSString *)resultKey
{
    return nil;
}

+ (NSString *)representUrl
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (void)fetchAsync:(SRFetchCompletionBlock)completionBlock
{
    [self doesNotRecognizeSelector:_cmd];
}

+ (void)fetchAsyncWithParams:(NSDictionary *)params async:(SRFetchCompletionBlock)completionBlock
{
    [self doesNotRecognizeSelector:_cmd];
}

// get "many" resource
+ (void)remoteAllAsync:(SRFetchCompletionBlock)completionBlock
{
    NSLog(@"remoteAllAsync:");
    [self remoteAllWithOptions:nil async:completionBlock];
}

+ (void)remoteAllWithOptions:(NSDictionary *)options async:(SRFetchCompletionBlock)completionBlock
{
    Class cls = object_getClass((id)[self class]);
    SEL sel = @selector(resultKey);
    Method mtd = class_getClassMethod(cls, @selector(resultKeyForMany));
    IMP imp = method_getImplementation(mtd);
    class_replaceMethod(cls, sel, imp, method_getTypeEncoding(mtd));
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [self baseurl], [self representUrlForMany]];
    urlString = [self buildQueryStringWithUrlString:urlString options:options];
    
    [self fetchURL:urlString async:^(NSArray *allRemote, NSError *error) {
        completionBlock(allRemote, error);
    }];
}

// get "one" resource
+ (void)remoteObjectWithID:(NSNumber *)remoteID async:(SRFetchObjectCompletionBlock)completionBlock
{
    NSLog(@"remoteObjectWithID:async:");
    [self remoteObjectWithID:remoteID options:nil async:completionBlock];
}

+ (void)remoteObjectWithID:(NSNumber *)remoteID options:(NSDictionary *)options async:(SRFetchObjectCompletionBlock)completionBlock
{
    Class cls = object_getClass((id)[self class]);
    SEL sel = @selector(resultKey);
    Method mtd = class_getClassMethod(cls, @selector(resultKeyForOne));
    IMP imp = method_getImplementation(mtd);
    class_replaceMethod(cls, sel, imp, method_getTypeEncoding(mtd));
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [self baseurl], [self representUrlForOneWithRemoteID:remoteID]];
    urlString = [self buildQueryStringWithUrlString:urlString options:options];
    
    [self fetchURL:urlString async:^(NSArray *allRemote, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        }
        else {
            completionBlock(allRemote[0], error);
        }
    }];
}

+ (NSString *)buildQueryStringWithUrlString:(NSString *)urlString options:(NSDictionary *)options
{
    for (NSString *key in [options allKeys]){
        if ([urlString rangeOfString:@"?"].location == NSNotFound){
            urlString = [urlString stringByAppendingFormat:@"?%@=%@", key, [options objectForKey:key]];
        }else{
            urlString = [urlString stringByAppendingFormat:@"&%@=%@", key, [options objectForKey:key]];
        }
    }
    return urlString;
}

#pragma mark -
#pragma mark below methods shoul be override in a subclass
+ (NSString *)representUrlForMany
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
+ (NSString *)representUrlForOneWithRemoteID:(NSNumber *)remoteID
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
+ (NSString *)resultKeyForMany
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
+ (NSString *)resultKeyForOne
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
