//
//  ObjectCreator.h
//  GolfFramework
//
//  Created by Vladimir Gogunsky on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectCreator : NSObject

+ (NSMutableArray *)createObjectsArrayFromPayloadArray	:(NSArray *)payloadArray
					forKey								:(NSString *)key
					withEntityClass						:(Class)entityClass;

@end
