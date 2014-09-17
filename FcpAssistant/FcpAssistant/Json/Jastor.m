#import "Jastor.h"
#import "JastorRuntimeHelper.h"

@implementation Jastor

@synthesize objectId;
static NSString *idPropertyName = @"id";
static NSString *idPropertyNameOnObject = @"objectId";

Class nsDictionaryClass;
Class nsArrayClass;


+ (id)initObject:(id)obj fromDictionary:(NSDictionary *)dictionary {
    if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
    if (!nsArrayClass) nsArrayClass = [NSArray class];
    
    if (obj) {
        for (NSString *key in [JastorRuntimeHelper propertyNames:[obj class]]) {
            
            id value = [dictionary valueForKey:[[Jastor map:obj]  valueForKey:key]];
            
            if (value == [NSNull null] || value == nil) {
                continue;
            }
            
            if ([JastorRuntimeHelper isPropertyReadOnly:[obj class] propertyName:key]) {
                continue;
            }
            
            // handle dictionary
            if ([value isKindOfClass:nsDictionaryClass])
            {
                Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[obj class]];
                id subObject = [[klass alloc] init];
                value = [self initObject:subObject fromDictionary:value];
            }
            // handle array
            else if ([value isKindOfClass:nsArrayClass]) {
                
                NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
                
                for (id child in value) {
                    if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                        Class arrayItemType = [[obj class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
                        if ([arrayItemType isSubclassOfClass:[NSDictionary class]]) {
                            [childObjects addObject:child];
                        } else if ([arrayItemType isSubclassOfClass:[NSObject class]]) {
                            id childDTO = [[arrayItemType alloc] init];
                            childDTO = [Jastor initObject:childDTO fromDictionary:child];
                            [childObjects addObject:childDTO];
                        }
                    } else {
                        [childObjects addObject:child];
                    }
                }
                
                value = childObjects;
            }
            // handle all others
            [obj setValue:value forKey:key];
        }
        
//        id objectIdValue;
//        if ((objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
//            if (![objectIdValue isKindOfClass:[NSString class]]) {
//                objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
//            }
//            [obj setValue:objectIdValue forKey:idPropertyNameOnObject];
//        }
    }
    return obj;
}


//+ (id)objectFromDictionary:(NSDictionary*)dictionary {
//    id item = [[self alloc] initWithDictionary:dictionary];
//    return item;
//}
//
//- (id)initWithDictionary:(NSDictionary *)dictionary {
//	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
//	if (!nsArrayClass) nsArrayClass = [NSArray class];
//	
//	if ((self = [super init])) {
//		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
//			
//			id value = [dictionary valueForKey:[[self map] valueForKey:key]];
//			
//			if (value == [NSNull null] || value == nil) {
//                continue;
//            }
//            
//            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
//                continue;
//            }
//			
//			// handle dictionary
//			if ([value isKindOfClass:nsDictionaryClass]) {
//				Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
//				value = [[klass alloc] initWithDictionary:value];
//			}
//			// handle array
//			else if ([value isKindOfClass:nsArrayClass]) {
//				
//				NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
//				
//				for (id child in value) {
//                    if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
//                        Class arrayItemType = [[self class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
//                        if ([arrayItemType isSubclassOfClass:[NSDictionary class]]) {
//                            [childObjects addObject:child];
//                        } else if ([arrayItemType isSubclassOfClass:[Jastor class]]) {
//                            Jastor *childDTO = [[arrayItemType alloc] initWithDictionary:child];
//                            [childObjects addObject:childDTO];
//                        }
//					} else {
//						[childObjects addObject:child];
//					}
//				}
//				
//				value = childObjects;
//			}
//			// handle all others
//			[self setValue:value forKey:key];
//		}
//		
//		id objectIdValue;
//		if ((objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
//			if (![objectIdValue isKindOfClass:[NSString class]]) {
//				objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
//			}
//			[self setValue:objectIdValue forKey:idPropertyNameOnObject];
//		}
//	}
//	return self;	
//}

- (void)dealloc {
	self.objectId = nil;
	
//	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
//		//[self setValue:nil forKey:key];
//	}
	
	//[super dealloc];
}

- (void)encodeWithCoder:(NSCoder*)encoder {
	[encoder encodeObject:self.objectId forKey:idPropertyNameOnObject];
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		[encoder encodeObject:[self valueForKey:key] forKey:key];
	}
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		[self setValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
		
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			id value = [decoder decodeObjectForKey:key];
			if (value != [NSNull null] && value != nil) {
				[self setValue:value forKey:key];
			}
		}
	}
	return self;
}

+ (NSMutableDictionary *)toDictionary:(id)obj {
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
//    if (obj) {
//        [dic setObject:obj forKey:idPropertyName];
//    }
	
	for (NSString *key in [JastorRuntimeHelper propertyNames:[obj class]]) {
		id value = [obj valueForKey:key];
        if (value && [value isKindOfClass:[NSObject class]] && [value isKindOfClass:[NSString class]] == NO) {
			[dic setObject:[Jastor toDictionary:value] forKey:[[Jastor map:obj] valueForKey:key]];
        } else if (value && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count > 0) {
            id internalValue = [value objectAtIndex:0];
            if (internalValue && [internalValue isKindOfClass:[NSObject class]]) {
                NSMutableArray *internalItems = [NSMutableArray array];
                for (id item in value) {
                    [internalItems addObject:[Jastor toDictionary:item]];
                }
				[dic setObject:internalItems forKey:[[Jastor map:obj] valueForKey:key]];
            } else {
				[dic setObject:value forKey:[[Jastor map:obj] valueForKey:key]];
            }
        } else if (value != nil) {
			[dic setObject:value forKey:[[Jastor map:obj] valueForKey:key]];
        }
	}
    return dic;
}

+ (NSDictionary *)map:(id)obj {
    NSArray *properties = [JastorRuntimeHelper propertyNames:[obj class]];
    NSMutableDictionary *mapDictionary = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
    for (NSString *property in properties) {
        [mapDictionary setObject:property forKey:property];
    }
    return [NSDictionary dictionaryWithDictionary:mapDictionary];
}

- (NSDictionary *)map {
	NSArray *properties = [JastorRuntimeHelper propertyNames:[self class]];
	NSMutableDictionary *mapDictionary = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
	for (NSString *property in properties) {
		[mapDictionary setObject:property forKey:property];
	}
	return [NSDictionary dictionaryWithDictionary:mapDictionary];
}

- (NSString *)description:(id)obj {
    NSMutableDictionary *dic = [Jastor toDictionary:obj];
	
	return [NSString stringWithFormat:@"#<%@: id = %@ %@>", [obj class], obj, [dic description]];
}

- (BOOL)isEqual:(id)object {
	if (object == nil || ![object isKindOfClass:[Jastor class]]) return NO;
	
	Jastor *model = (Jastor *)object;
	
	return [self.objectId isEqualToString:model.objectId];
}

@end
