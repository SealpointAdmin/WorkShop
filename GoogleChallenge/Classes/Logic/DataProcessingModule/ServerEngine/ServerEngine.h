//
//  ServerEngine.h
//  GolfFramework
//
//  Created by Vladimir Gogunsky on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

@interface ServerEngine : MKNetworkEngine

						  typedef void (^ ServerResponseBlock)(NSObject *object);

- (MKNetworkOperation *)executeTaskWithOnCompletion :(ServerResponseBlock) completionBlock
						onError						:(MKNKErrorBlock)errorBlock, ...;
@end
