//
//  PrivateTag.m
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/14.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "PrivateTag.h"

@implementation PrivateTag

+ (NSString *)representUrl
{
    return @"private_tags.json";
}

+ (NSString *)resultKey
{
    return @"objects";
}

@end
