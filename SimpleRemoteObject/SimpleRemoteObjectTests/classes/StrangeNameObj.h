//
//  StrangeNameObj.h
//  SimpleRemoteObject
//
//  Created by Shiro Nohara on 2013/07/19.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "SRSimpleRemoteObject.h"

@interface StrangeNameObj : SRSimpleRemoteObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *comment;

@end
