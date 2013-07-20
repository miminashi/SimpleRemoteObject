//
//  SRSimpleRESTRemoteObject.h
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/11.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "SRSimpleRemoteObject.h"

typedef void(^SRFetchObjectCompletionBlock)(id object, NSError *error);

@interface SRSimpleRESTRemoteObject : SRSimpleRemoteObject

+ (void)remoteAllAsync:(SRFetchCompletionBlock)completionBlock;
+ (void)remoteObjectWithID:(NSNumber *)remoteID async:(SRFetchObjectCompletionBlock)completionBlock;
+ (void)remoteAllWithOptions:(NSDictionary *)options async:(SRFetchCompletionBlock)completionBlock;
+ (void)remoteObjectWithID:(NSNumber *)remoteID options:(NSDictionary *)options async:(SRFetchObjectCompletionBlock)completionBlock;

/*
 // should override on subclass
 */
+(NSString *)representUrlForMany;
+(NSString *)representUrlForOneWithRemoteID:(NSNumber *)remoteID;
+(NSString *)resultKeyForMany;
+(NSString *)resultKeyForOne;

@end
