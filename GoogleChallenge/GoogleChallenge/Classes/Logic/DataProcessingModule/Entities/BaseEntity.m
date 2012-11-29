#import "BaseEntity.h"
#include <objc/runtime.h>

// Private interface
@interface BaseEntity ()

// can be placed as NSObject category method
+ (NSMutableArray *)getClassProperties;
+ (NSMutableArray *)getClassInstances;

@end

@implementation BaseEntity

#define SM_ENTITY_ID		@"id"
#define SM_ENTITY_TIMESTAMP @"timestamp"

@synthesize timestamp;
@synthesize smID;
@synthesize name;

#pragma mark -
#pragma mark Debug mode

+ (BOOL)useMock
{
	return YES;
}

#pragma mark -
#pragma mark Initialization

- (id)initWithDictionary:(NSDictionary *)theDictionary
{
	self = [super init];

	if (self) {
		[self setValuesForKeysWithDictionary:theDictionary];
	}

	return self;
}

// FIXME: approach of properties (ivars) naming!
- (void)setValue:(id)value forKey:(NSString *)key
{
	if ([key isEqualToString:SM_ENTITY_ID]) {
		[self setSmID:value];
	} else if ([key isEqualToString:SM_ENTITY_TIMESTAMP]) {
		[self setTimestamp:[value doubleValue]];
	} else {
		[super setValue:value forKey:key];
	}
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	// DLOG(@"WARNING: Undefined key found. Class:%@. key:%@, value:%@", [[self class] description], key, value);
}

#pragma mark -
#pragma mark Converting

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues {
    [keyedValues setValue:@"" forKey:@"name"];
    [super setValuesForKeysWithDictionary:keyedValues];
}

- (id)getValueFromDictionary:(NSDictionary *)theDictionary andKey:(NSString *)theKey
{
	id obj = [theDictionary objectForKey:theKey];

	if (obj == nil) {
		//		DLOG(@"WARNING: Unsupported key. Class:%@. key:%@",[[self class] description], theKey);
	}

	return obj;
}

- (NSMutableDictionary *)extractDictionary
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];

	NSArray *properties = [[self class] getClassProperties];

	for (NSUInteger i = 0; i < [properties count]; ++i) {
		NSString *_name = [properties objectAtIndex:i];

		id value = [self valueForKey:_name];

		if (value == nil) {
			value = [NSNull null];
		}

		[dict setObject:value forKey:[self keyForProperty:_name]];
	}

	return [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (NSString *)keyForProperty:(NSString *)theProperty
{
	if ([theProperty isEqualToString:@"smID"]) {
		return SM_ENTITY_ID;
	} else if ([theProperty isEqualToString:@"timestamp"]) {
		return SM_ENTITY_TIMESTAMP;
	} else {
		return theProperty;
	}
}

#pragma mark -
#pragma mark Private methods

+ (NSMutableArray *)getClassProperties
{
	NSMutableArray *array = nil;

	if ([self superclass] != [NSObject class]) {
		array = (NSMutableArray *)[[self superclass] getClassProperties];
	} else {
		array = [NSMutableArray array];
	}

	NSUInteger cnt = 0;

	objc_property_t *properties = class_copyPropertyList([self class], &cnt);

	for (NSUInteger i = 0; i < cnt; ++i) {
		NSString *name = [NSString stringWithUTF8String:property_getName(properties[i])];
		[array addObject:name];
	}

	free(properties);

	return array;
}

+ (NSMutableArray *)getClassInstances
{
	NSMutableArray *array = nil;

	if ([self superclass] != [NSObject class]) {
		array = (NSMutableArray *)[[self superclass] getClassInstances];
	} else {
		array = [NSMutableArray array];
	}

	NSUInteger cnt = 0;

	Ivar *ivars = class_copyIvarList([self class], &cnt);

	for (NSUInteger i = 0; i < cnt; ++i) {
		NSString		*name	= [NSString stringWithUTF8String:ivar_getName(ivars[i])];
		NSString		*type	= [NSString stringWithUTF8String:ivar_getTypeEncoding(ivars[i])];
		NSDictionary	*dict	= [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", type, @"type", nil];
		[array addObject:dict];
	}

	free(ivars);

	return array;
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	NSArray *ivars = [[self class] getClassInstances];

	for (NSUInteger i = 0; i < [ivars count]; ++i) {
		NSString *_name = [[ivars objectAtIndex:i] objectForKey:@"name"];

		id value = [self valueForKey:_name];

		if (value == nil) {
			value = [NSNull null];
		}

		if ([value conformsToProtocol:@protocol(NSCoding)]) {
			[aCoder encodeObject:value forKey:_name];
		}
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super init]) {
		NSArray *ivars = [[self class] getClassInstances];

		for (NSUInteger i = 0; i < [ivars count]; ++i) {
			NSString *_name = [[ivars objectAtIndex:i] objectForKey:@"name"];

			id ddd = [aDecoder decodeObjectForKey:_name];

			if (ddd != nil) {
				[self setValue:ddd forKey:_name];
			}
		}
	}

	return self;
}

- (NSString *)toString
{
	NSString *result = [NSString stringWithFormat:@"\n ***** %@ *****\n", NSStringFromClass([self class])];

	NSMutableDictionary *dict	= [self extractDictionary];
	NSArray				*keys	= [dict allKeys];

	for (NSString *key in keys) {
		result = [result stringByAppendingFormat:@"   \"%@\" --> %@ \n", key, [dict objectForKey:key]];
	}

	return result;
}

@end
