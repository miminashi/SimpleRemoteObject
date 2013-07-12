//
//  RESTTag.h
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/11.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "SRSimpleRESTRemoteObject.h"

@interface RESTTag : SRSimpleRESTRemoteObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *resource_uri;
@property(nonatomic,retain) NSString *slug;

@end
