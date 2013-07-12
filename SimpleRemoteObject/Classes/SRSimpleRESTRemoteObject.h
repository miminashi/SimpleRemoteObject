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

+ (void)remoteObjectsAsync:(SRFetchCompletionBlock)completionBlock;
+ (void)remoteObjectWithID:(NSNumber *)remoteID async:(SRFetchObjectCompletionBlock)completionBlock;

@end
