//
//  DataManager.h
//  GolfFramework
//
//  Created by Vladimir Gogunsky on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ServerEngine.h"

#define DATA_MANAGER [DataManager sharedManager]

typedef enum ResponseDataType {
	JSON,
	XML,
	PLIST,
} ResponseDataType;

@interface DataManager : NSObject {
	ServerEngine *serverEngine_;
}

@property (nonatomic, copy)     NSString			*defaultHostName;
@property (nonatomic, assign)   BOOL				SSL;
@property (nonatomic, assign)   ResponseDataType	responseDataType;
@property (nonatomic, copy)     NSString			*defaultHttpMethod;

@property (nonatomic, assign) int countOfRequestsWithLoadingIndicator;

+ (id)sharedManager;

- (void) setup ;

- (void)fetchDataWithTarget :(id) target
		completionCallback	:(SEL) completionCallback
		errorCallback		:(SEL) errorCallback
		url					:(NSString *)url
		params				:(NSMutableDictionary *)params
		httpMethod			:(NSString *)httpMethod
		useCache			:(BOOL) useCache
		useLoadingIndicator :(BOOL)useLoadingIndicator;

- (void)fetchDataWithTarget :(id) target
		completionCallback	:(SEL) completionCallback
		errorCallback		:(SEL) errorCallback
		params				:(NSMutableDictionary *)params;

- (void)fetchDataWithTarget :(id) target
		completionCallback	:(SEL) completionCallback
		errorCallback		:(SEL) errorCallback
		params				:(NSMutableDictionary *)params
		useLoadingIndicator :(BOOL)useLoadingIndicator;

- (void)fetchDataWithTarget :(id) target
		completionCallback	:(SEL) completionCallback
		errorCallback		:(SEL) errorCallback
		params				:(NSMutableDictionary *)params
		useCache			:(BOOL)useCache;

- (void)cancel;

@end
