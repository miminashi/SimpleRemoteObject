//
//  RESTTag.m
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/11.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "RESTTag.h"

@implementation RESTTag

+ (NSString *)representResourceName {
    return @"tags";
}

+(NSString *)resultKeyForMany{
    NSLog(@"resultKeyForMany invoked");
    return @"objects";
}

+(NSString *)resultKeyForOne{
    NSLog(@"resultKeyForOne invoked");
    return @"object";
}

@end
