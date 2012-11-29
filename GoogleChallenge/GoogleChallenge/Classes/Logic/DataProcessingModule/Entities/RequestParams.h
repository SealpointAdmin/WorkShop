//
//  RequestParams.h
//  Tournament
//
//  Created by Vladimir Gogunsky on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface RequestParams : BaseEntity

@property (nonatomic, strong) NSObject				*target;
@property (nonatomic, strong) NSString				*completionCallback;
@property (nonatomic, strong) NSString				*errorCallback;
@property (nonatomic, strong) NSMutableDictionary	*params;
@property (nonatomic, strong) NSMutableDictionary	*userData;

@end
