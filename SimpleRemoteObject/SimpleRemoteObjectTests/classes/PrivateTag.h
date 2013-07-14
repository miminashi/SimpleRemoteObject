//
//  PrivateTag.h
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/14.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "SRSimpleRemoteObject.h"

@interface PrivateTag : SRSimpleRemoteObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *resource_uri;
@property(nonatomic,retain) NSString *slug;

@end
