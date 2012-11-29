//
//  ObjectCreator.m
//  GolfFramework
//
//  Created by Vladimir Gogunsky on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectCreator.h"
#import "BaseEntity.h"

@interface ObjectCreator (Private)

@end

@implementation ObjectCreator

+ (NSMutableArray *)createObjectsArrayFromPayloadArray	:(NSArray *)payloadArray
					forKey								:(NSString *)key
					withEntityClass						:(Class)entityClass
{
	NSMutableArray *objectsArray = [[NSMutableArray alloc] init];

	for (NSDictionary *dict in [[payloadArray objectAtIndex:0] objectForKey : key]) {
		BaseEntity *entity = [[BaseEntity alloc] initWithDictionary:dict];
		[objectsArray addObject:entity];
	}

	return objectsArray;
}

@end
