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
    Class cls = object_getClass((id)[self class]);
    SEL sel = @selector(resultKey);
    Method mtd = class_getClassMethod(cls, @selector(resultKeyForMany));
    IMP imp = method_getImplementation(mtd);
    class_replaceMethod(cls, sel, imp, method_getTypeEncoding(mtd));
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@.json", [self baseurl], [[self class] performSelector:@selector(representResourceName)]];
    return urlString;
}

+ (NSString *)representUrlWithID:(NSNumber *)remoteID
{
    Class cls = object_getClass((id)[self class]);
    SEL sel = @selector(resultKey);
    Method mtd = class_getClassMethod(cls, @selector(resultKeyForOne));
    IMP imp = method_getImplementation(mtd);
    class_replaceMethod(cls, sel, imp, method_getTypeEncoding(mtd));
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@.json", [self baseurl], [[self class] performSelector:@selector(representResourceName)], remoteID];
    return urlString;
}

+ (void)remoteObjectsAsync:(SRFetchCompletionBlock)completionBlock
{
    NSLog(@"remoteObjectsAsync:");
//    [self fetchURL:[self representUrl] async:completionBlock];
//    [[self class] performSelector:@selector(fetchURL:async:) withObject:[self representUrl] withObject:completionBlock];
    [self fetchURL:[self representUrl] async:^(NSArray *allRemote, NSError *error) {
        completionBlock(allRemote, error);
    }];
}

+ (void)remoteObjectWithID:(NSNumber *)remoteID async:(SRFetchObjectCompletionBlock)completionBlock
{
    [self fetchURL:[self representUrlWithID:remoteID] async:^(NSArray *allRemote, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        }
        else {
            completionBlock(allRemote[0], error);
        }
    }];
}

@end
