//
//  StrangeNameObj.m
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/19.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "StrangeNameObj.h"

@implementation StrangeNameObj

+ (NSString *)representUrl
{
    return @"strange_name_object.json";
}

+ (NSString *)resultKey
{
    return @"objects";
}

- (NSString *)propertyForRemoteKey:(NSString *)remoteKey
{
    if ([remoteKey isEqualToString:@"description"]) {
        return @"comment";
    }
    return [super propertyForRemoteKey:remoteKey];
}

@end
