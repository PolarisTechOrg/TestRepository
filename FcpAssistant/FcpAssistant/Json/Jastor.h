//
//  Jastor.h
//  Jastor
//
//  Created by Elad Ossadon on 12/14/11.
//  http://devign.me | http://elad.ossadon.com | http://twitter.com/elado
//

@interface Jastor : NSObject <NSCoding>

@property (nonatomic, copy) NSString *objectId;
//+ (id)objectFromDictionary:(NSDictionary*)dictionary;
//
//- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (id)initObject:(id)obj fromDictionary:(NSDictionary *)dictionary;

+ (NSMutableDictionary *)toDictionary:(id)obj;

- (NSDictionary *)map;

@end
