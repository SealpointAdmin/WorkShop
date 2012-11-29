//
//  GCPlaceDetail.m
//  GoogleChallenge
//
//  Created by admin on 10/26/12.
//  Copyright (c) 2012 Vladimir Gogunsky. All rights reserved.
//

#import "GCPlaceDetail.h"

@interface GCPlaceDetail()

+ (id)placeFromDictionary:(NSDictionary *)dict;

@end

@implementation GCPlaceDetail

@synthesize name = name_;
@synthesize lat = lat_;
@synthesize lng = lng_;
@synthesize icon = icon_;
@synthesize placeID = placeID_;
@synthesize rating = rating_;
@synthesize reference = reference_;
@synthesize types = types_;
@synthesize formatted_address = formatted_address_;
@synthesize opening_hours = opening_hours_;
@synthesize formatted_phone_number = formatted_phone_number_;
@synthesize events = events_;
@synthesize international_phone_number = international_phone_number_;
@synthesize reviews = reviews_;

#pragma mark - Private methods

+ (id)placeFromDictionary:(NSDictionary *)dict {
    GCPlaceDetail *place = [[GCPlaceDetail alloc] init];
    
    for (NSString *key in [dict allKeys]) {
        if ([key isEqualToString:@"id"]) {
            id val = [dict objectForKey:key];
            [place initID:val];
            
            continue;
        }
        
        if ([key isEqualToString:@"geometry"]) {
            id val = [dict objectForKey:key];
            [place initLatLong:val];
            continue;
        }
        
        id val = [dict objectForKey:key];
        [place setValue:val forKey:key];
    }
    
    return place;
}

#pragma mark - Class initialize methods

+ (id)placeFromDetailDictionary:(NSDictionary *)dict {
    return [self placeFromDictionary:dict];
}

+ (id)placeFromSearchDictionary:(NSDictionary *)dict {
    return [self placeFromDictionary:dict];
}

#pragma mark - Object methods

- (void)initLatLong:(id)geometry {
    id val = [geometry objectForKey:@"location"];
    [self setValue:[val objectForKey:@"lat"] forKey:@"lat"];
    [self setValue:[val objectForKey:@"lng"] forKey:@"lng"];
}

- (void)initID:(id)placeID {
    [self setValue:placeID forKey:@"placeID"];
}

@end
