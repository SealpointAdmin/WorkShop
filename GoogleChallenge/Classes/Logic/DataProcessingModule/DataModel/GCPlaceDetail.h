//
//  GCPlaceDetail.h
//  GoogleChallenge
//
//  Created by admin on 10/26/12.
//  Copyright (c) 2012 Vladimir Gogunsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface GCPlaceDetail : NSObject

@property (nonatomic, strong) NSString * formatted_address;
@property (nonatomic, strong) NSString * formatted_phone_number;
@property (nonatomic, strong) NSString * reference;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * placeID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * international_phone_number;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * vicinity;
@property (nonatomic, strong) NSString * website;

@property (nonatomic, strong) NSNumber * lat;
@property (nonatomic, strong) NSNumber * lng;
@property (nonatomic, strong) NSNumber * rating;

@property (nonatomic, strong) NSArray * types;
@property (nonatomic, strong) NSArray * events;
@property (nonatomic, strong) NSArray * reviews;

@property (nonatomic, strong) NSDictionary * opening_hours;


+ (id)placeFromSearchDictionary:(NSDictionary *)dict;
+ (id)placeFromDetailDictionary:(NSDictionary *)dict;

- (void)initLatLong:(id)geometry;
- (void)initID:(id)placeID;

@end
