@interface BaseEntity : NSObject <NSCoding>{
	double		timestamp;
	NSString	*smID;
	NSString	*name;
}

@property (readwrite) double			timestamp;
@property (nonatomic, copy) NSString	*smID;
@property (nonatomic, copy) NSString	*name;

#pragma mark Debug mode
// For providing fake data or not
+ (BOOL)useMock;

#pragma mark Initialization
- (id)initWithDictionary:(NSDictionary *)theDictionary;

#pragma mark Converting
- (id)getValueFromDictionary:(NSDictionary *)theDictionary andKey:(NSString *)theKey;
- (NSMutableDictionary *)extractDictionary;
- (NSString *)keyForProperty:(NSString *)theProperty;

- (NSString *)toString;

@end
