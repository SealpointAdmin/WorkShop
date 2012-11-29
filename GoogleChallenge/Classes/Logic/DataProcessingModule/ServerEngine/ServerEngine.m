//
//  ServerEngine.m
//  GolfFramework
//
//  Created by Vladimir Gogunsky on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerEngine.h"

@interface ServerEngine ()

@end

@implementation ServerEngine

- (MKNetworkOperation *)executeTaskWithOnCompletion :(ServerResponseBlock)completionBlock
						onError						:(MKNKErrorBlock)errorBlock, ...
	{
	va_list args;

	va_start(args, errorBlock);

	NSString			*url		= va_arg(args, NSString *);
	NSMutableDictionary *params		= va_arg(args, NSMutableDictionary *);
	NSString			*httpMethod = va_arg(args, NSString *);
	BOOL				ssl			= (BOOL)va_arg(args, NSString *);
	va_end(args);

	MKNetworkOperation *op = [self	operationWithPath	:url
									params				:params
									httpMethod			:httpMethod
									ssl					:ssl];
	[op onCompletion:^(MKNetworkOperation * completedOperation) {
			DLog (@"Data from server %@", [completedOperation responseString]);

			completionBlock ([completedOperation responseString]);
		} onError:^(NSError * error) {
			errorBlock (error);
		}];

	[self enqueueOperation:op];

	return op;
}

@end
