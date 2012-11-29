//
//  DataManager.m
//  GolfFramework
//
//  Created by Vladimir Gogunsky on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataManager.h"
#import <objc/message.h>

@interface DataManager ()

@property (nonatomic, strong) MKNetworkOperation *currentOperation;

- (NSObject *)convertObject :(NSObject *)object
   toCurrentDataType		:(ResponseDataType)dataType;
@end

@implementation DataManager

@synthesize currentOperation;
@synthesize defaultHostName;
@synthesize defaultHttpMethod;
@synthesize SSL;
@synthesize responseDataType;
@synthesize countOfRequestsWithLoadingIndicator;

+ (id)sharedManager
{
	static dispatch_once_t	once;
	static DataManager		*shared;

	dispatch_once(&once, ^{shared = [[self alloc] init]; });

	return shared;
}

- (id)init
{
	self = [super init];

   
	return self;
}


- (void) setup {
    [self setDefaultHttpMethod:@"GET"];
	[self setSSL:TRUE];
	[self setResponseDataType:JSON];
    
	serverEngine_ = [[ServerEngine alloc] initWithHostName:[self defaultHostName]];
	[serverEngine_ useCache];
}

- (void)fetchDataWithTarget :(id)target
		completionCallback	:(SEL)completionCallback
		errorCallback		:(SEL)errorCallback
		url					:(NSString *)url
		params				:(NSMutableDictionary *)params
		httpMethod			:(NSString *)httpMethod
		useCache			:(BOOL)useCache
		useLoadingIndicator :(BOOL)useLoadingIndicator
{
	if (useCache) {
		// TODO: TRY TO GET DATA FROM CACHE
	}
	MKNetworkOperation *theCurrentOperation = [serverEngine_	executeTaskWithOnCompletion :^(NSObject * object) {
			NSObject *result = [self	convertObject		:object
										toCurrentDataType	:[self responseDataType]];
			objc_msgSend (target, completionCallback, result);
		}
																onError						:^(NSError *error) {

			objc_msgSend (target, errorCallback, error);
		}, url, params, httpMethod, [self SSL]];

	[self setCurrentOperation:theCurrentOperation];
}

- (void)fetchDataWithTarget :(id)target
		completionCallback	:(SEL)completionCallback
		errorCallback		:(SEL)errorCallback
		params				:(NSMutableDictionary *)params
{
	[self	fetchDataWithTarget :target
			completionCallback	:completionCallback
			errorCallback		:errorCallback
			url					:nil
			params				:params
			httpMethod			:[self defaultHttpMethod]
			useCache			:FALSE
			useLoadingIndicator :TRUE];
}

- (void)fetchDataWithTarget :(id)target
		completionCallback	:(SEL)completionCallback
		errorCallback		:(SEL)errorCallback
		params				:(NSMutableDictionary *)params
		useLoadingIndicator :(BOOL)useLoadingIndicator
{
	[self	fetchDataWithTarget :target
			completionCallback	:completionCallback
			errorCallback		:errorCallback
			url					:nil
			params				:params
			httpMethod			:[self defaultHttpMethod]
			useCache			:FALSE
			useLoadingIndicator :useLoadingIndicator];
}

- (void)fetchDataWithTarget :(id)target
		completionCallback	:(SEL)completionCallback
		errorCallback		:(SEL)errorCallback
		params				:(NSMutableDictionary *)params
		useCache			:(BOOL)useCache
{
	[self	fetchDataWithTarget :target
			completionCallback	:completionCallback
			errorCallback		:errorCallback
			url					:nil
			params				:params
			httpMethod			:[self defaultHttpMethod]
			useCache			:useCache
			useLoadingIndicator :TRUE];
}

- (void)cancel
{
	[[self currentOperation] cancel];
}

#pragma mark -
#pragma mark ===   Private ===

- (NSObject *)	convertObject		:(NSObject *)object
				toCurrentDataType	:(ResponseDataType)dataType
{
	switch (dataType) {
		case JSON:
			{
				NSString *responseString = (NSString *)object;

				if ([[responseString objectFromJSONString] isKindOfClass:[NSDictionary class]]) {
					return [NSArray arrayWithObject:[responseString objectFromJSONString]];
				}

				return [responseString objectFromJSONString];

				break;
			}

		default:
			break;
	}

	return nil;
}

@end
